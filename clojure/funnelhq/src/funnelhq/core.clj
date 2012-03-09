(ns funnelhq.core
  (use [clojure.java.io :as io]))

(def ^{:dynamic true} *rails-log-file* "log/development.log")

(defprotocol FunnelIO
  "A protocol for reading and writing"
  (read-file [this])
  (write-file [this]))

(extend-protocol FunnelIO
  String
  (read-file [file] 
    (with-open [rdr (clojure.java.io/reader file)]
      (reduce conj [] (line-seq rdr))))
  (write-file [text dest & opts]
    (with-open [w (clojure.java.io/writer dest ~@opts)]
	    (.write w text))))


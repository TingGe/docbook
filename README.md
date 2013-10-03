XMLmind免费的XML编辑器
================

[下载][12]

[12]: <http://www.xmlmind.com/xmleditor/download.shtml>

使用
--

[XMLmind XML编辑器——官网首页教程][13]

[13]: <http://www.xmlmind.com/xmleditor/_primer/xxe_primer.swf>

[XMLmind XML编辑器——在线帮助][1]

[1]: <http://wenku.it168.com/d_000553069.shtml>

参考
--

[在路上][14]

[14]: <http://www.crifan.com/category/work_and_job/docbook/>



ZoeeyDoc DocBook文档构建工具
======================

ZoeeyDoc 是一个docbook文档构建工具，支持 single-html、html、chm、pdf 等格式导出。对中文支持良好。

优点
--

-   纯文本格式：基于xml，纯文本格式方便版本控制。章节可分为独立的文件和目录进行编辑。

-   多格式发布：经过一次书写便可以输出html、chm、pdf等众多格式，极大的方便了阅读。

-   排版格式：排版格式精良。DocBook与专业排版工具TeX实力相当。常用来制作出版发行物、专业论文、软件手册等。

-   格式规范：纯xml格式，有众多编辑工具，格式规范便于自动检验。

-   中文支持：良好的中文支持自动引用系统字体生成pdf所需的字体描述文件。

-   自动化支持：采用纯命令行形式，可方便的加入到各类自动构建工具中。

-   人工服务：本地化，中文在线问题疑难解答。

-   其他：生成single-html、html等格式会自动打包为zip文件。且zip、pdf、chm等文件会自动生成checksum 校验文件。

下载
--

http://code.google.com/p/zoeeydoc/

手册
--

+--------+----------+----------------+----------------+
| 格式     | 地址       | checksum       | 备注             |
+--------+----------+----------------+----------------+
| chm    | [chm][4] | [checksum][8]  | 无法查看：文件属性，解除锁定 |
+--------+----------+----------------+----------------+
| html   | [zip][5] | [checksum][9]  |                |
+--------+----------+----------------+----------------+
| pdf    | [pdf][6] | [checksum][10] |                |
+--------+----------+----------------+----------------+
| single | [zip][7] | [checksum][11] |                |
+--------+----------+----------------+----------------+

[4]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.chm>

[5]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.zip>

[6]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.pdf>

[7]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc-single.zip>

[8]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.chm.checksum>

[9]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.zip.checksum>

[10]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc.pdf.checksum>

[11]: <http://zoeeydoc.googlecode.com/hg/build/zoeeydoc-single.zip.checksum>

示例项目
----

<http://code.google.com/p/cnphpdocs/> 【含文档源码、各格式下载】

<http://code.google.com/p/yafphp/> 【含文档源码】

<http://code.google.com/p/zoeeyphp/> 【含文档源码、各格式下载】

使用说明
----

======================== ZoeeyDoc help: ======================== -h/--help :
打印此文档。

-c/--clean :  清理缓存文件。

-t/--type :  转换目标类型（chm,html,single/singlehtml），默认为 html。

-b/--book :  文档目录。 文件配置文件为文件路径+"/config.kv"

获取帮助 java -jar ZoeeyDoc.jar -h

生成 html java -jar ZoeeyDoc.jar -b docs/books/zoeeydoc -t html

生成 single html java -jar ZoeeyDoc.jar -b docs/books/zoeeydoc -t single

生成 chm （需要指定hhc目录） java -jar ZoeeyDoc.jar -b docs/books/zoeeydoc -t chm

参考资料
----

[DocBook][1]  
  
[DocBook XSL: The Complete Guide][2]  
  
[ZoeeyDoc 使用技巧][3]

[1]: <http://www.docbook.org/>

[2]: <http://www.sagehill.net/docbookxsl/index.html>

[3]: <http://blog.zoeey.org/2011/03/12/zoeeydoc-docbook/>

其它
--

java运行所需要的Jre：[Jre][1]

[1]: <http://www.java.com/en/download/index.jsp>

chm生成需要的hhc:[Microsoft HTML Help Downloads][2]

[2]: <http://msdn.microsoft.com/en-us/library/ms669985%28v=vs.85%29.aspx>

java运行所需要的Jre：[Jre][1]

[1]: <http://www.java.com/en/download/index.jsp>

chm生成需要的hhc:[Microsoft HTML Help Downloads][2]

[2]: <http://msdn.microsoft.com/en-us/library/ms669985%28v=vs.85%29.aspx>

ZoeeyDoc作者
----------

email: system128@gmail.com

qq: 5943590

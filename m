From: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] Remaining patches in my queue for IR
Date: Sun, 17 Oct 2010 00:56:27 +0200
Message-ID: <1287269790-17605-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lirc-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/lirc-list>,
	<mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=lirc-list>
List-Post: <mailto:lirc-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/lirc-list>,
	<mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: lirc-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lirc-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

This series is rebased on top of media_tree/staging/v2.6.37 only.
Really this time, sorry for cheating, last time :-)

The first patch like we agreed extends the raw packets.
It touches all drivers (except imon as it isn't a raw IR driver).
Code is compile tested with all drivers, 
and run tested with ENE and all receiver protocols
(except the streamzap rc5 flavour)
Since it also moves timeouts to lirc bridge, at least streazap driver
should have its timeout gap support removed. I am afraid to break the code
if I do so.

Other 2 patches are ENE specific, and don't touch anything else.

Please test other drivers.

Best regards,
	Maxim Levitsky


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev

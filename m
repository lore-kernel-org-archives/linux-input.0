From: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/2] xen pvfb: Para-virtual
	framebuffer, keyboard and pointer
Date: Thu, 21 Feb 2008 12:51:21 +0100
Message-ID: <87hcg2cyti.fsf@pike.pond.sub.org>
References: <871w76ejdg.fsf@pike.pond.sub.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <871w76ejdg.fsf@pike.pond.sub.org> (Markus Armbruster's message
	of "Thu\, 21 Feb 2008 10\:42\:03 +0100")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net, akpm@linux-foundation.org, jayakumar.lkml@gmail.com
List-Id: linux-input@vger.kernel.org

Forgot to mention: This patch depends on

    Subject: [PATCH] xen: Make xen-blkfront write its protocol ABI to xenstore
    From: Markus Armbruster <>
    Date: Thu, 06 Dec 2007 14:45:53 +0100

http://lkml.org/lkml/2007/12/6/132

Sorry!

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

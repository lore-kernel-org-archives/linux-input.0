From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/2] xen pvfb: Para-virtual framebuffer,	keyboard and
 pointer
Date: Thu, 21 Feb 2008 14:33:05 -0800
Message-ID: <47BDFC21.6010604@goop.org>
References: <871w76ejdg.fsf@pike.pond.sub.org>	<87hcg2cyti.fsf@pike.pond.sub.org> <47BDD4BF.3000808@goop.org> <871w76ca0i.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765918AbYBUWge@vger.kernel.org>
In-Reply-To: <871w76ca0i.fsf@pike.pond.sub.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Armbruster <armbru@redhat.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net, akpm@linux-foundation.org, jayakumar.lkml@gmail.com
List-Id: linux-input@vger.kernel.org

Markus Armbruster wrote:
> Here's the description again:
>
>     Frontends are expected to write their protocol ABI to xenstore.  Since
>     the protocol ABI defaults to the backend's native ABI, things work
>     fine without that as long as the frontend's native ABI is identical to
>     the backend's native ABI.  This is not the case for xen-blkfront
>     running 32-on-64, because its ABI differs between 32 and 64 bit, and
>     thus needs this fix.
>
> I can break the dependency by putting the same bug that is now in
> xen-blkfront into xen-fbfront and xen-kbdfront.
>   

Right, I see.  The dependency is on the protocols.h changes.

    J

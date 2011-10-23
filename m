From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Staging: hv: mousevsc: Move the mouse driver out of
	staging
Date: Sun, 23 Oct 2011 14:33:07 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481AA33663@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1318658907-16698-1-git-send-email-kys@microsoft.com>
	<20111023072427.GA13268@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20111023072427.GA13268@core.coreip.homeip.net>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Sunday, October 23, 2011 3:24 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; linux-
> input@vger.kernel.org; Haiyang Zhang; Jiri Kosina
> Subject: Re: [PATCH 1/1] Staging: hv: mousevsc: Move the mouse driver out of
> staging
> 
> Hi K. Y.,
> 
> On Fri, Oct 14, 2011 at 11:08:27PM -0700, K. Y. Srinivasan wrote:
> > In preparation for moving the mouse driver out of staging, seek community
> > review of the mouse driver code.
> >
> 
> Because it is a HID driver it should go through Jiri Kosina's tree
> (CCed). Still, a few comments below.

Thanks Dmitry. I will address the comments you have given me, and will
work with Jiri to get this driver out of staging.

Regards,

K. Y

From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] HID: Removed obsolete comment from roccat kone
 driver
Date: Mon, 31 May 2010 13:56:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005311355180.28092@pobox.suse.cz>
References: <1274899850.9492.1.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274899850.9492.1.camel@localhost>
Sender: linux-doc-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 26 May 2010, Stefan Achatz wrote:

> Removed comment that is obsolete since roccat char device is
> implemented
> 
> Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
> ---
>  drivers/hid/hid-roccat-kone.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
> index 17f2dc0..3e5b553 100644
> --- a/drivers/hid/hid-roccat-kone.c
> +++ b/drivers/hid/hid-roccat-kone.c
> @@ -22,11 +22,6 @@
>   *      Is it possible to remove and reinstall the urb in raw-event- or any
>   *      other handler, or to defer this action to be executed somewhere else?
>   *
> - * TODO implement notification mechanism for overlong macro execution
> - *      If user wants to execute an overlong macro only the names of macroset
> - *      and macro are given. Should userland tap hidraw or is there an
> - *      additional streaming mechanism?
> - *
>   * TODO is it possible to overwrite group for sysfs attributes via udev?
>   */

Hi Stefan,

I have applied all three patches in the series. Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

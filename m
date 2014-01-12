From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Drivers: input: serio:hyperv-keyoard:  Handle 0xE1
 prefix
Date: Sun, 12 Jan 2014 11:14:36 -0800
Message-ID: <20140112191436.GB13131@core.coreip.homeip.net>
References: <1389498110-4790-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1389498110-4790-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: olaf@aepfle.de, gregkh@linuxfoundation.org, jasowang@redhat.com, linux-kernel@vger.kernel.org, vojtech@suse.cz, linux-input@vger.kernel.org, apw@canonical.com, devel@linuxdriverproject.org
List-Id: linux-input@vger.kernel.org

On Sat, Jan 11, 2014 at 07:41:50PM -0800, K. Y. Srinivasan wrote:
> Handle the 0xE1 prefix.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

Applied, thank you.

> ---
>  drivers/input/serio/hyperv-keyboard.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> index 3a83c3c..6132619 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -160,7 +160,9 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
>  			if (info & IS_E0)
>  				serio_interrupt(kbd_dev->hv_serio,
>  						XTKBD_EMUL0, 0);
> -
> +			if (info & IS_E1)
> +				serio_interrupt(kbd_dev->hv_serio,
> +						XTKBD_EMUL1, 0);
>  			scan_code = __le16_to_cpu(ks_msg->make_code);
>  			if (info & IS_BREAK)
>  				scan_code |= XTKBD_RELEASE;
> -- 
> 1.7.4.1
> 

-- 
Dmitry

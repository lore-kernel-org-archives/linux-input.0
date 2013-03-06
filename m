From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH v1 7/7] usbnet: qmi_wwan: don't recover device if suspend fails in system sleep
Date: Wed, 06 Mar 2013 13:07:03 +0100
Message-ID: <8738w8ohp4.fsf@nemi.mork.no>
References: <1362565557-15884-1-git-send-email-ming.lei@canonical.com>
	<1362565557-15884-8-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1362565557-15884-8-git-send-email-ming.lei@canonical.com> (Ming
	Lei's message of "Wed, 6 Mar 2013 18:25:56 +0800")
Sender: netdev-owner@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.de>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Ming Lei <ming.lei@canonical.com> writes:

> If suspend callback fails in system sleep context, usb core will
> ignore the failure and let system sleep go ahead further, so
> this patch doesn't recover device under this situation.
>
> Cc: Bj=C3=B8rn Mork <bjorn@mork.no>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
>  drivers/net/usb/qmi_wwan.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index efb5c7c..1b4367c 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -294,7 +294,7 @@ static int qmi_wwan_suspend(struct usb_interface =
*intf, pm_message_t message)
> =20
>  	if (intf =3D=3D info->control && info->subdriver && info->subdriver=
->suspend)
>  		ret =3D info->subdriver->suspend(intf, message);
> -	if (ret < 0)
> +	if (ret < 0  && PMSG_IS_AUTO(message))
>  		usbnet_resume(intf);
>  err:
>  	return ret;

Same comment as for cdc_mbim: This is more confusing than helpful
because it makes it look like qmi_wwan_suspend can return an error on
system suspend.  Better adding a comment explaining why the original
code is OK.


Bj=C3=B8rn

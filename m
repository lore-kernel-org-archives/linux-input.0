From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: rmi: Protect PM-only functions by #ifdef
 CONFIG_PM
Date: Thu, 12 Jun 2014 10:29:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1406121029000.1321@pobox.suse.cz>
References: <1402513398-17546-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41429 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932740AbaFLIbk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jun 2014 04:31:40 -0400
In-Reply-To: <1402513398-17546-1-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 11 Jun 2014, Geert Uytterhoeven wrote:

> If CONFIG_PM=3Dn:
>=20
> drivers/hid/hid-rmi.c:432: warning: =E2=80=98rmi_post_reset=E2=80=99 =
defined but not used
> drivers/hid/hid-rmi.c:437: warning: =E2=80=98rmi_post_resume=E2=80=99=
 defined but not used
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/hid/hid-rmi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 2451c7e5febd..578bbe65902b 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -428,6 +428,7 @@ static int rmi_raw_event(struct hid_device *hdev,
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM
>  static int rmi_post_reset(struct hid_device *hdev)
>  {
>  	return rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
> @@ -437,6 +438,7 @@ static int rmi_post_resume(struct hid_device *hde=
v)
>  {
>  	return rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
>  }
> +#endif /* CONFIG_PM */
> =20
>  #define RMI4_MAX_PAGE 0xff
>  #define RMI4_PAGE_SIZE 0x0100

Applied, thanks for spotting it.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

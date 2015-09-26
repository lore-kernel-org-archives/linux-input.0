From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Subject: Re: [PATCH] HID: hid-input: allow input_configured callback return
 errors
Date: Sat, 26 Sep 2015 20:48:57 +0300
Message-ID: <5606DA89.9060505@redhat.com>
References: <20150925231451.GA40951@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56900 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445AbbIZRtI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Sep 2015 13:49:08 -0400
In-Reply-To: <20150925231451.GA40951@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: =?windows-1252?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Jaikumar Ganesh <jaikumarg@android.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, James C Boyd <jcboyd.dev@gmail.com>, Karl Relton <karllinuxtest.relton@ntlworld.com>, David Herrmann <dh.herrmann@gmail.com>, Olivier Gay <ogay@logitech.com>, Ross Skaliotis <rskaliotis@gmail.com>, Jamie Lentin <jm@lentin.co.uk>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andreas Fleig <andreasfleig@gmail.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Peter Wu <peter@lekensteyn.nl>, Goffredo Baroncelli <kreijack@inwind.it>, Mathieu Magnaudet <mathieu.magnaudet@gmail.com>, Brent Adam <brentadamdev@gmail.com>, Yang Bo <linuxsea@163.com>, Seth Forshee <seth.forshee@canonical.com>, Andrew Duggan <aduggan@synaptics.com>, Dan Carpenter <dan.carpenter@oracle.com>Frank Praznik <f>

On 09/26/2015 02:14 AM, Dmitry Torokhov wrote:
> When configuring input device via input_configured callback we may
> encounter errors (for example input_mt_init_slots() may fail). Instead
> of continuing with half-initialized input device let's allow driver
> indicate failures.
>
> diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> index b905d50..85ac435 100644
> --- a/drivers/hid/hid-uclogic.c
> +++ b/drivers/hid/hid-uclogic.c
> @@ -731,7 +731,7 @@ static int uclogic_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>   	return 0;
>   }
>
> -static void uclogic_input_configured(struct hid_device *hdev,
> +static int uclogic_input_configured(struct hid_device *hdev,
>   		struct hid_input *hi)
>   {
>   	char *name;
> @@ -741,7 +741,7 @@ static void uclogic_input_configured(struct hid_device *hdev,
>
>   	/* no report associated (HID_QUIRK_MULTI_INPUT not set) */
>   	if (!hi->report)
> -		return;
> +		return 0;
>
>   	field = hi->report->field[0];
>
> @@ -774,6 +774,8 @@ static void uclogic_input_configured(struct hid_device *hdev,
>   			hi->input->name = name;
>   		}
>   	}
> +
> +	return 0;
>   }
>
>   /**

The hid-uclogic.c change looks perfectly fine to me.

Thank you, Dmitri.

The next step would be to report devm_kzalloc failure instead of ignoring it.

Nick

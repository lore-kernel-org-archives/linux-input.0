Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B239027BF79;
	Mon, 27 Jul 2026 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178147; cv=none; b=WW8dW6aRvGssOowE+YggwejapQUxDq2ogs+h86w2uufawKI5BCfnzX6IVjWIYrv7KejRMo++SXJILnacFV4Nif3oPJsrVQm99OB4Kfe4mNb0c3l2aMziWk//Y6C/60ECQgPI3hoHP70sN723f35HnDwFd2W8rNyAuCjKxt42Vhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178147; c=relaxed/simple;
	bh=sdibMjrE53bNcnGaQM1R0ZH7iHbiTf+FWnYq9vpQVTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lvSMAmfBUQgVHOeyLIR/EJqA8j5VUqn1MqaHE/RdIUL8NMx++YpKu1BOLfjmHHoI4bpxqIqWtQA4/CzuhR+iDBa9pvZCLysWrTsI7GquQwX7O3kYDV9NkhQUJ2dANnxLY6SmAcBbj3PxihlwPGomoiKSw3rwOs+4L6ithPkGJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pYg9gGzH; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pYg9gGzH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785178105; x=1785782905; i=w_armin@gmx.de;
	bh=ffJJp7/Va1mMGka3wkp/6IIdEZyfzETwBtHL7ADVb7o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pYg9gGzHDQfdH2xhUmBFpJE6f0geEzBysDYkAJEoYSE2q/XX0TnAZZvgrPj6jhap
	 RPPKD/AakMW0sMD5NgkMyaC2lKp3qOJUUsTfZAhYhIzaKRYplNPa+D+5aRjIFctbF
	 zTqkoMYZsQ/Uz61BuOQ88yYU7oxZdbSduIgiqaMvxnZlNIWLVl8M3eIAUGc3OyuQA
	 XLsof8u6o6lwq2CuuwSzrAxE0UyGTYPmKZew4G2ZwMnsRooG3YRle2HnvUyg86gSj
	 z0e62kouJf7ik4esZfLndMGm5o8MuFg6BMpHvzEBwlR/pSMLXnaslDvV0HeIUyxYr
	 d8KJxWld3CKo9NI32Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhlf-1wderI43HT-00BpDJ; Mon, 27
 Jul 2026 20:48:24 +0200
Message-ID: <5da17298-2c2d-435c-9765-9e8392ecc2f4@gmx.de>
Date: Mon, 27 Jul 2026 20:48:09 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/13] platform/x86: uniwill-wmi: use
 devm_blocking_notifier_chain_register()
To: Eliav Farber <farbere@amazon.com>, rafael@kernel.org,
 tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
 xueshuai@linux.alibaba.com, lenb@kernel.org,
 laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org,
 orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, dmitry.torokhov@gmail.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, ukleinek@kernel.org,
 fabio.m.de.francesco@linux.intel.com, kaihengf@nvidia.com,
 ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, paulmck@kernel.org,
 frederic@kernel.org, kees@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-11-farbere@amazon.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260726101739.33170-11-farbere@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vs1b0LaSo/qxKYf/8gleZOsZN6lTqcJmRVvPE8FO+L4UkNVT2FG
 8yI38HsJEmviJFDm/9fFclvEQvGDQ70byqbuLlGS6Bw7o5IGMe4XgSIIvv0krqxxIRJdvO7
 eeHsKUoD/dkggSgz1tmezR+7HrPyzjRFEtrTyALy49LX/85krjtE830vCzQ5vuZXAeCJNQh
 r8ZwZxlecvnWJdrV4nUdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BOeNCAFWQC8=;Z86xhvBKajZZz8GOJsZ6MXkOAKx
 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

Am 26.07.26 um 12:17 schrieb Eliav Farber:
> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> devm_uniwill_wmi_unregister_notifier() callback.
>=20

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>   drivers/platform/x86/uniwill/uniwill-wmi.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/platform/x86/uniwill/uniwill-wmi.c b/drivers/platfo=
rm/x86/uniwill/uniwill-wmi.c
> index afcbfa4f7552..2ffa29a829ee 100644
> --- a/drivers/platform/x86/uniwill/uniwill-wmi.c
> +++ b/drivers/platform/x86/uniwill/uniwill-wmi.c
> @@ -26,22 +26,11 @@
>  =20
>   static BLOCKING_NOTIFIER_HEAD(uniwill_wmi_chain_head);
>  =20
> -static void devm_uniwill_wmi_unregister_notifier(void *data)
> -{
> -	struct notifier_block *nb =3D data;
> -
> -	blocking_notifier_chain_unregister(&uniwill_wmi_chain_head, nb);
> -}
> -
>   int devm_uniwill_wmi_register_notifier(struct device *dev, struct noti=
fier_block *nb)
>   {
> -	int ret;
> -
> -	ret =3D blocking_notifier_chain_register(&uniwill_wmi_chain_head, nb);
> -	if (ret < 0)
> -		return ret;
> -
> -	return devm_add_action_or_reset(dev, devm_uniwill_wmi_unregister_notif=
ier, nb);
> +	return devm_blocking_notifier_chain_register(dev,
> +						     &uniwill_wmi_chain_head,
> +						     nb);
>   }
>  =20
>   static void uniwill_wmi_notify(struct wmi_device *wdev, union acpi_obj=
ect *obj)


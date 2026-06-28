Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE327291C10
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665381; cv=none; b=ohSy969zv3lOAN8PpXoKA2R2P9u2WvFLF0T+TMPoa3ut/nLA/n9fpG/uKF4/Vuufi2E97rrb3krHf2FbUE1tdN0ZG/pyDOvB33fdF7yo4PLdVPuEMQmnFWKlG7krJbDnxri01/hWpWM+v+awvi8RRicJ4KHMVoJ8LUK93twlZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665381; c=relaxed/simple;
	bh=iOs2E6wuYvwp1GOr6KOr/8Q6vxOo4B7F9n5gWoinPWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uyk/NohzgOA1l42kf8/eTOVw0pL7CPX/FJsUqQDAwwnflyZBLtVF14P9YQMGJia5QFc9Z0bnp1O+QGPRw/aRjhJZ0BbZ6AwoSzpT9EeGxJ88VFqSBVWYQVXpjNqXhGlQ1BPw2vXRebAw/CFPXWmLfvSog7mkh9sblBNW6h8YSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnNsPNuD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnNsPNuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5F21F000E9;
	Sun, 28 Jun 2026 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782665380;
	bh=Np1hWtLGDNb1EY7COrnRgnX59X7LNk5AT+7YQW8VzFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DnNsPNuDKx8UNNho98IPvZNNNr4bx1zLwZY7eWk5OefgeLEbz7xxqzsP0manzaJUS
	 JUI88NJZejLA4sUgX7BhbF9r+xBClo8li7nRpINzB/UsNWbzPar3RknqAy/WXhdO2z
	 hk1VBTeoYgl/kj2D0E14UFpVSAEWxiE15eRKM102tgt9yY8Gqs6roExu2dHrwqoEMQ
	 Jk6ICHwGT1hWp4BYJ75rWWQV19g1L4+C5/hp+mQQa5Cj/H2ALLNWzBFslcMrOCUqPK
	 RmXktZkJKWcrv/BTuZbdJQgpT3Mwx9WBWAdg8w/gorkyWchlHA0K9Uwxu3BYZoaP3E
	 3d5+Kd8Q5X3gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] HID: roccat-savu: reject short special reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628163527.14279-4-alhouseenyousef@gmail.com>
References: <20260628163527.14279-1-alhouseenyousef@gmail.com>
 <20260628163527.14279-4-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 16:49:39 +0000
Message-Id: <20260628164940.2F5F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver acquires a mutex in the raw_event handler path, which e=
xecutes in atomic (softIRQ) context, leading to a scheduling-while-atomic b=
ug or deadlock.
- [Medium] The roccat driver leaks the memory allocated for circular buffer=
 reports when the device is destroyed.
--

commit 60d1ec57aac96f7ad83f249887da4a3aa3a3f7c4
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: roccat-savu: reject short special reports

savu_report_to_chrdev() casts special reports to a five-byte structure and
reads all of its payload fields without checking the received size. A
malformed USB device can therefore trigger out-of-bounds reads from the
input buffer when the character device is claimed. Pass the report size
into the helper and require the complete structure.

> diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
> index 6791369335601..04fa4c50cfa4b 100644
> --- a/drivers/hid/hid-roccat-savu.c
> +++ b/drivers/hid/hid-roccat-savu.c

[ ... ]

> @@ -183,7 +184,7 @@ static int savu_raw_event(struct hid_device *hdev,
>  		return 0;
> =20
>  	if (savu->roccat_claimed)
> -		savu_report_to_chrdev(savu, data);
> +		savu_report_to_chrdev(savu, data, size);

[Severity: High]
This is a pre-existing issue, but can this lead to a scheduling-while-atomic
bug?

The savu_raw_event() callback runs in atomic context (softIRQ). When it
calls savu_report_to_chrdev(), the execution path proceeds to
roccat_report_event() in drivers/hid/hid-roccat.c, which acquires
sleeping locks:

drivers/hid/hid-roccat.c:roccat_report_event() {
    ...
    mutex_lock(&device->readers_lock);
    mutex_lock(&device->cbuf_lock);
    ...
}


[Severity: Medium]
This is also a pre-existing issue, but does this code leak the memory
allocated for circular buffer reports when the device is destroyed?

In drivers/hid/hid-roccat.c:roccat_report_event(), kmemdup() dynamically
allocates memory for the report:

    new_value =3D kmemdup(data, device->report_size, GFP_ATOMIC);

However, when the device is freed in roccat_release() or
roccat_disconnect() using kfree(device), the dynamically allocated report
values in the circular buffer do not appear to be cleaned up.

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628163527.1427=
9-1-alhouseenyousef@gmail.com?part=3D4

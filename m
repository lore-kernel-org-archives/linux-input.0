Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24933D4E2
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482447; cv=none; b=LmWn348Ut0wd0thcDA+T42+8zXy/eRn/uoDeRdfhfUr46dpKwvmpBSqY1ug+gsfBpnUi9zIOYkEztfll0AWFu3ImXlMn8Bj156Y43DkWuS3sl3eRUx4cW71O5QZ8HaV6rBqyPGkBfiUm3+Mq4hQj7y10iodXARdWBp+0vNTDF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482447; c=relaxed/simple;
	bh=QYDJX6ad0eUTRD/NTWxjeFLYQwVSh9n5bW3GqYxJ64E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FKCwUgLHa/59JW89WY0EmzSTFWpw34OWww5fNC3Qq9qxE8eQVHh1VQvZWpAfbRK0NuoHMvJ4B/UUcwzLhXg2qPy//nj+0VBZ9tyjHDmT3u0WDTFQLgkBwTtUYn2rYmtK1WspV58dKPLOXdeet0MAsbR+WFSi/ixwbhfzWpoKuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvpImu3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvpImu3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236D21F000FF;
	Tue, 15 Sep 2026 14:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482446;
	bh=dY94lW1MVtZplNLIIXunZT1cO5ilFu501G/wnhTG5Lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gvpImu3FlHjy7NGrK8kULnL3B/vm1uhxnesz811WGVrgr1z9osunsWabcf7/obiLh
	 g139YZe8DkKXk6CIRbUQLtC6d+la7BqvyeoPIsui/JPR2MzxQ8mt/xDqSNSGVvOIPk
	 xwTk96q9xzUfXdRBcaQClSj3YLjEWrhVHFg4J+SvuxlvDpbw7yxR39fn52yadz+IDC
	 OTBSWIJpaK6zsU1CHqIMYfyZIf0zAcj+xEQtV25p4dLqwNkOHKbVdU+N75DHCgpdhA
	 i3YKqU9ZdpXiPTW60ati5XslefObNUwj/8V1oh0/AU9GKW2gDh/vJrN18MWgTlPMcU
	 Tubh+ri6yW5fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: wacom: avoid overflows in sequence number
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260915141621.3011011-1-qwe.aldo@gmail.com>
References: <20260915111448.2726869-1-qwe.aldo@gmail.com>
 <20260915141621.3011011-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:27:25 +0000
Message-Id: <20260915142726.236D21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] hid: wacom: 64-bit modulo operation breaks 32-bit builds
--

commit 07dd42ab3d43fb513fdcf25e5070f8dd85e2b11c
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

HID: wacom: avoid overflows in sequence number tracking

This commit updates the dropped-packet calculation to use signed 64-bit=20
arithmetic to prevent divide exceptions caused by 32-bit wrap-arounds. It a=
lso=20
normalizes the sequence values according to the HID parser's signedness rul=
es.

Fixes: 359673ea3a20 ("HID: wacom: Support sequence numbers smaller than 16-=
bit")
Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 8feb8027be95e..ff99ba259b030 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2542,18 +2542,34 @@ static void wacom_wac_pen_event(struct hid_device=
 *hdev, struct hid_field *field
>  	case WACOM_HID_WD_BARRELSWITCH3:
>  		wacom_wac->hid_data.barrelswitch3 =3D value;
>  		return;
> -	case WACOM_HID_WD_SEQUENCENUMBER:
> -		if (wacom_wac->hid_data.sequence_number !=3D value &&
> +	case WACOM_HID_WD_SEQUENCENUMBER: {
> +		s64 sequence_minimum =3D field->logical_minimum;
> +		s64 sequence_maximum =3D sequence_minimum < 0 ?
> +			(s64)field->logical_maximum :
> +			(s64)(u32)field->logical_maximum;
> +		s64 sequence_value =3D sequence_minimum < 0 ?
> +			(s64)value : (s64)(u32)value;
> +
> +		if (wacom_wac->hid_data.sequence_number !=3D sequence_value &&
>  		    wacom_wac->hid_data.sequence_number >=3D 0) {
> -			int sequence_size =3D field->logical_maximum - field->logical_minimum=
 + 1;
> -			int drop_count =3D (value - wacom_wac->hid_data.sequence_number) % se=
quence_size;
> -			hid_warn(hdev, "Dropped %d packets", drop_count);
> +			s64 sequence_size =3D sequence_maximum -
> +					    sequence_minimum + 1;
> +			s64 drop_count =3D sequence_value -
> +					 wacom_wac->hid_data.sequence_number;
> +
> +			drop_count %=3D sequence_size;

[Severity: Low]
Will this raw 64-bit modulo operation cause link-time build failures on 32-=
bit
architectures?

The variables drop_count and sequence_size are both s64. On 32-bit systems
(like i386 or arm32), the kernel does not link __moddi3, so using the raw
modulo operator on 64-bit integers typically results in an unresolved symbol
build failure.

Should this use a helper from <linux/math64.h>, such as div64_s64_rem(), to
safely perform the calculation while ensuring 32-bit compatibility?

> +			if (drop_count < 0)
> +				drop_count +=3D sequence_size;
> +			hid_warn(hdev, "Dropped %lld packets",
> +				 (long long)drop_count);
>  		}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915141621.3011=
011-1-qwe.aldo@gmail.com?part=3D1

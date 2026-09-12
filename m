Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D342F361B
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183724; cv=none; b=VzLjwUjWfOo3BAF9aMaxFPT6cD/lm7Rmma+5q9GLQTFqTx6F0Q0Hdbg7EMGuhbMHWp3xU1d4dP+YCHqpjHrpTHJ3WYQA8B7arqLaRg3ScpuuSN6Wizu3pJQCBCeITs7+eNkMVS0wlBxUVANQfLOw/w/9tYaXJBjtyfriKK/w974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183724; c=relaxed/simple;
	bh=t50jBOJWOhkUfmC81c3SlfJsbPZAY3XbkrqkgKq8uO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DzZqxWhCD5iqVT0w+6nppJiFaqzpy0Qaby6XtN9QlILLhKde6NT4af+KCC2VtYMnAHedHOcT+R9ZwekyMWSn2gHHf+FvlUPoCxEjZzG/oD1CNV7XqJOyPVMK0rrGt+ZOlN/iZKjX+JU6N/WSmRowopzUv8RM/A51K3wdx+GQZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBZUUVoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBZUUVoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF3E1F000FF;
	Sat, 12 Sep 2026 03:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183723;
	bh=PCRXkamCgWV9P0kIYhyOxJl6zf/8fnZkOTcuggomtc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oBZUUVoJoc/dgbDJiwpw0EwMlGvwVcF9X45yqw3stO8Ly+2as/E8lWFNn3VXTno+Y
	 KE/7sZkqnhH7tVNWnZjqRAMUWuY6XNcKptrstkfYtLna8511oV98riUGc7BOyYEPvl
	 Ihs+DoXGiPfOKT0g13vDapQzFIjLeLSxOOHD8xyJqLokNESVUqE7r3527PALQq0Cle
	 JNTaPvgarHsT2fX5rErog1LvdXJWpIAPy/HYMfOMzR7D6jz9H7txF4B9fLkCcAUNoA
	 pYuqmFt3TH77xLP36ERHcz//lNsF7ZKHBFk+Db9EKL+utPBZlry8+m1jng/p8U6Dg3
	 sw/LfZgqhPoNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/12] HID: Map more automobile simulation inputs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912030426.2997003-12-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-12-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:28:42 +0000
Message-Id: <20260912032843.4AF3E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid-universal-pidff: Loop boundary hardcodes ABS_BRAKE, missing =
the newly added ABS_CLUTCH and ABS_SHIFTER axes.
--

commit 5a43f61b9ef2583fea1214cddf577437072e1c07
Author: Vicki Pfau <vi@endrift.com>

HID: Map more automobile simulation inputs

This commit maps the previously ignored HID usages for clutch and shifter=20
to ABS_CLUTCH and ABS_SHIFTER in hidinput_configure_usage.

> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 3487600cadb42..6ade969412c67 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -828,6 +828,8 @@ static void hidinput_configure_usage(struct hid_input=
 *hidinput, struct hid_fiel
>  		case 0xbb: map_abs(ABS_THROTTLE); break;
>  		case 0xc4: map_abs(ABS_GAS);      break;
>  		case 0xc5: map_abs(ABS_BRAKE);    break;
> +		case 0xc6: map_abs(ABS_CLUTCH);   break;
> +		case 0xc7: map_abs(ABS_SHIFTER);  break;

[Severity: Medium]
Does this change unintentionally leave the new simulation axes with large
default deadzones on devices handled by the hid-universal-pidff driver?

In drivers/hid/hid-universal-pidff.c, the universal_pidff_input_configured
function explicitly attempts to clear default deadzones for simulation axes
to ensure high precision. However, it relies on a hardcoded loop boundary:

for (axis =3D ABS_X; axis <=3D ABS_BRAKE; axis++) {
        ...
}

Since ABS_CLUTCH and ABS_SHIFTER are numerically greater than ABS_BRAKE,
the loop will miss these newly mapped axes. This introduces an unwanted
default deadzone of 1/16th of their range on the clutch and shifter axes,
which might degrade the simulation experience for users of high-end sim
racing wheels.

Should the loop boundary in universal_pidff_input_configured be updated to
include these new axes?

>  		case 0xc8: map_abs(ABS_WHEEL);    break;
>  		default:   goto ignore;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D11

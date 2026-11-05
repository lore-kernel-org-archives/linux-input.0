Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793906418;
	b=i9YAvQ6PeMI16VtEO1ql9IxtbVviKYXGa0c7dvSg6kDeEMX6yyCT9tJLDWY3LXuZ2iGn
	 qQVJTucRq9hzgLND/5G0nQ1OxbxynRi61vj5yk8D+Lnwfu1gpP6R6dhdopIZ9MnZODhJ1
	 ugBglDhnORC22M3S30BUaOnH2WQL4a/MVG+WokAM+eJHEOqjtWWSswCtl0GbrF4L9kmfE
	 gSkpMRnkzELeaQDnC1aC/Du7nnhOXEqDUJ97QXimDIhS4uBxADo8zTfhV+26nRI5psqtt
	 h3o9osAL8fLLXVUlkScjGbZgwSUSlJKH3+WdcAf+WhhAFlq5EwGSepxC1bVyXpw/WoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Pp/TG21mhE7k1t/eWybpON9LpBrMSOVs3egyXyjekZI=;
	b=B7v9ygqm2jrwgjr8x+qVDi2yivLFXP5o144YDVJlnxlf0C6LgwmT6fkOe4IM5eJGPozA
	 6DD3hKe0ynNsy5pEHY4fkkoCb+1ftZjxgJEKeYDZBGxGZTKBztpivnZaHg/eFR5KSdY/u
	 b/VdsBv05fa0bV6fQdbzWZCh4zxGd5J6RE2YAEWlkRHm5RaSjgyw2O456VTd6JTG/nCKn
	 62/oIiugYbVkAJgfnIdolVteHUYIZIY01fTWwO6I6SdfTi4aatakUWxYuofUElmsUznvM
	 adcpRP2SL/zkfvuqI+UCLMOPb0Z4Ye2A2cASu78XhL3s47GCLIlnlQxBGa5uWV9SzPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=goxBSdge;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C067606A328
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 19:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C067606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=goxBSdge
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e55db58cfso236245285a.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 11:20:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793906417; cv=none;
        d=google.com; s=arc-20260327;
        b=KZQKrmZeuRP3SdTTCYDbdyq9imyOyaBiq6pSaDLziMBjAcfBsIkx+6GyffLSK/BGd0
         gcigKJ98mNNFSs/lvJDnendw2CRjNqdIBW9TiuNJJ3hUdQpEnMHG4tT61lmBz+mc7t1n
         /FDTTM5ExqioTqkFdysd9lYsQSXHbjXTF81PL8gL4hw7sMtCmQ3kHJAqeVC9xlTGOoB/
         c4RXbAftZ28Is+0v/84Py5KxyiE/lxCGgORCYxNr853MOFFNM1AOplXEGmILi9LiExfU
         D3HEsNfke6bxgXUxRk4G7ei/bgu7h9x/XwE0YQ8smSLWYBATeHe42ED4WejTLgu6su3r
         5cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pp/TG21mhE7k1t/eWybpON9LpBrMSOVs3egyXyjekZI=;
        fh=lDOjw1taoUVt0rYH/y9MiOFngVjQA0MuBEQ/0ruVtmg=;
        b=hhllQSWbxpW2ODwsCSDB3kvdeD+eyNizhDKsO73+xUuMOEGWtdxA/5Pa3TSJLHNuby
         e5AQee1wHPsL/UDUaRgZvoxaJFV+GsfMjMIzpC6pBHSVRQKHfh7sV01cOnb0vlEJf2sl
         MJffjHnY+bnAc53pKYqOpu1aam+bvodE/58tNUMe8JDMFnAfpILzeyuZZKXQX78aQwOG
         yoanw1xJgjHnQNeCHG0JSbmUyMIwhlGRxnZh14TvZQxpP1vBPUlJGIrOQp1yecYhD6q2
         f2woDz5yn1nICvxSq5/AfvqCJjhd0KItZnzywGb6O4WzK1nMUqiIsW5MvRZDR8be0Dwn
         TDcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793906417; x=1794511217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pp/TG21mhE7k1t/eWybpON9LpBrMSOVs3egyXyjekZI=;
        b=goxBSdgeBbdHj66o9Nu3RNovXtI7CJhsb0Rr7p21S9IEWF5RADy2eV4UGrMXXidFAl
         cTO0oAVzKBF5fO9sS/GOG37u8hhgHva6nZ/mle/Tp3bNfFyFKTXYJRAtKuu76p953xid
         afvRQG/ybr6Ut8n2erud5xXY/aDItoKUKt6VGisPWURfTnLLI1F9adpLJGkPPQQMKa2X
         3ygmX5UszfB7oFk/DshDKWoLiKPhzINYoTv7p/1tfte7N6+0mVfMFUUBEkGXI5WX1y1F
         TaRwiDOCSfgP1UpHoUWjnfCzogY3bzcRPH7XygMsHTMFXkryttjpg7un4zngWdx12xFL
         huPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906417; x=1794511217;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pp/TG21mhE7k1t/eWybpON9LpBrMSOVs3egyXyjekZI=;
        b=ZJOQ23yVe1DMAWV0OtrAC8toBPB3p5sCSREzcGaRN0hFrOoiDIDbvHUD4N39Tk1gfr
         QkNNqqRYXRh/pgQAcFIdyvTkqLdfxgVw3myqA+9Pqnam6wkPLJE1nwMlyUKcBIrnMe8Q
         oSPv0sMrKf5Y0r0fAbWb9pU/fyWiswb0n9+hmNBbiajejQnqhv08dUfwsQW/TlNnjg61
         Z1cjHFO0+O/Pc0j5vfcBphRd+uZkHRdMUFbX0A0TnizF5Ce5OaSywyzJznUv41NUs7LL
         FvLLgG1I6Lxz1g2PCO6SPRlt4p+zsBX++8AWzw3w99Czflkp3/+M0Q2KzaH0sDQOBxkS
         PmlA==
X-Forwarded-Encrypted: i=1; AKwUvBwtUU0iL3Rdr6RSHmFExUAx9PPUJy+dC/KXg+3wI0AUEatK+c/+alu0PglkEEXVUNtmoWuCWuxPhgoMAw==@vger.kernel.org
X-Gm-Message-State: APuU4Z86AzkPtLVr7qBJO7cFg70iQiyvWaNvcK3lOnwVeQW/2ZE1QgLd
	277XC/uK1lPhm440fpJUYNFSKxHqVqi7UJS8BlvftpDsX8g1ncFk+rlG8rky2b2I1U6Y+OnMbZg
	/ErLGAoXmlMmVzk0EfsrQKXaWaQ0c5QA=
X-Gm-Gg: AYBFou2R+IXn4Rrnt1nHoiHBjrdej39pAQeMATk8yzJIpUPGZ5/4zhXIwcBSZpuWcRv
	h39T57I72LN1230ES09LVU7dKEeQ/GF7z2B7Aq9VyZ3mi0lq6ymR6afrav/NsVv8CP1JyStk8cI
	bGo/DgN7aBlPRgxYANUsmmiQM1adwPHMV419bIBCnVyMn11G1HjP/bIwKnxlSFYLXb14L2N8Xjd
	EkSWFmovDuxfU1rWmH+1L9xUFKQA89orR4xqpJacPrfoADvdi+h+IcmMyj0PL+hSByTJaKN48fU
	bw8Q2CVaAnkgr7QQ1HahXY7n49FNS/nPLIRFSo0j9Mc0FTWA5YanaH3fXtTSJz3RtEx/z5HNeN0
	SAz2VaUOw5Ukqq4NnUoD/YmlslpGq6wpES+SI
X-Received: by 2002:a05:620a:4015:b0:93c:c2c2:40eb with SMTP id
 af79cd13be357-945f35e6c2bmr5090185a.66.1793906416804; Thu, 05 Nov 2026
 11:20:16 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260915111448.2726869-1-qwe.aldo@gmail.com> <20260915145229.3036596-1-qwe.aldo@gmail.com>
In-Reply-To: <20260915145229.3036596-1-qwe.aldo@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Thu, 5 Nov 2026 11:20:05 -0800
X-Gm-Features: AclHuK-4ryZB_pVHQTvIJoueiQY69x_P5hoZ4Ix7YJII7Qwx1mdwYxlfMzqsWMk
Message-ID: <CANRwn3RYhEu0g9Lx+Vg=Uy8V7BWWz-jWV9d7UVuyRK-MGdbHOA@mail.gmail.com>
Subject: Re: [PATCH v3] HID: wacom: avoid overflows in sequence number tracking
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:17=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gmail=
.com> wrote:
>
> The dropped-packet calculation derives the sequence range in signed int
> arithmetic. A sequence field whose logical range spans all 32-bit values
> makes the range calculation wrap to zero, so the following modulo trigger=
s
> a divide exception.
>
> Normalize the maximum and current value according to the HID parser's
> signedness rule, and keep the sequence state and arithmetic in s64. Use
> div64_s64() for the remainder to avoid __moddi3 link failures on 32-bit
> architectures. This also avoids overflowing value + 1 at the logical
> maximum.
>
> Fixes: 359673ea3a20 ("HID: wacom: Support sequence numbers smaller than 1=
6-bit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---

Generally speaking, I feel like NAK-ing this patch as it currently is.
I'm happy to take a patch that specifically addresses the divide
exception, without expanding the size of sequence_number (mostly
because that particular part is a bit unnecessary with our hardware
unlikely to ever spend more than 32 bits on a sequence number). It
should be possible to introduce a helper function that calculates the
value with a branch rather than explicit division, e.g. something
like:

int wrapped_dist(int after, int before, int min, int max) {
        if (after >=3D before) {
               return after - before;
        }
       else {
              return (max - before) + (after - min) + 1;
       }
}

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>
> Changes in v3:
>   - Replace raw s64 modulo with div64_s64()-based remainder to avoid
>     __moddi3 link failure on 32-bit architectures (i386, arm32).
>     Reported by Sashiko AI review.
>
> Changes in v2:
>   - Normalize logical_maximum/value as unsigned when logical_minimum >=3D=
 0,
>     matching HID parser signedness. Store sequence state as s64.
>     Fixes unsigned 0..UINT32_MAX range that broke v1.
>
>  drivers/hid/wacom_wac.c | 33 ++++++++++++++++++++++++---------
>  drivers/hid/wacom_wac.h |  2 +-
>  2 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea856..af94f59a5d 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -7,6 +7,7 @@
>  #include "wacom.h"
>  #include <linux/input/mt.h>
>  #include <linux/jiffies.h>
> +#include <linux/math64.h>
>
>  /* resolution for penabled devices */
>  #define WACOM_PL_RES           20
> @@ -2527,18 +2528,33 @@ static void wacom_wac_pen_event(struct hid_device=
 *hdev, struct hid_field *field
>         case WACOM_HID_WD_BARRELSWITCH3:
>                 wacom_wac->hid_data.barrelswitch3 =3D value;
>                 return;
> -       case WACOM_HID_WD_SEQUENCENUMBER:
> -               if (wacom_wac->hid_data.sequence_number !=3D value &&
> +       case WACOM_HID_WD_SEQUENCENUMBER: {
> +               s64 sequence_minimum =3D field->logical_minimum;
> +               s64 sequence_maximum =3D sequence_minimum < 0 ?
> +                       (s64)field->logical_maximum :
> +                       (s64)(u32)field->logical_maximum;
> +               s64 sequence_value =3D sequence_minimum < 0 ?
> +                       (s64)value : (s64)(u32)value;
> +
> +               if (wacom_wac->hid_data.sequence_number !=3D sequence_val=
ue &&
>                     wacom_wac->hid_data.sequence_number >=3D 0) {
> -                       int sequence_size =3D field->logical_maximum - fi=
eld->logical_minimum + 1;
> -                       int drop_count =3D (value - wacom_wac->hid_data.s=
equence_number) % sequence_size;
> -                       hid_warn(hdev, "Dropped %d packets", drop_count);
> +                       s64 sequence_size =3D sequence_maximum -
> +                                           sequence_minimum + 1;
> +                       s64 drop_count =3D sequence_value -
> +                                        wacom_wac->hid_data.sequence_num=
ber;
> +
> +                       drop_count -=3D div64_s64(drop_count, sequence_si=
ze) *
> +                                     sequence_size;
> +                       if (drop_count < 0)
> +                               drop_count +=3D sequence_size;
> +                       hid_warn(hdev, "Dropped %lld packets",
> +                                (long long)drop_count);
>                 }
> -               wacom_wac->hid_data.sequence_number =3D value + 1;
> -               if (wacom_wac->hid_data.sequence_number > field->logical_=
maximum)
> -                       wacom_wac->hid_data.sequence_number =3D field->lo=
gical_minimum;
> +               if (sequence_value >=3D sequence_maximum)
> +                       wacom_wac->hid_data.sequence_number =3D sequence_=
minimum;
> +               else
> +                       wacom_wac->hid_data.sequence_number =3D sequence_=
value + 1;
>                 return;
>         }
> +       }
>
>         /* send pen events only when touch is up or forced out
>          * or touch arbitration is off
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 126bec6e5c..74e7c5a04a 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -324,7 +324,7 @@ struct hid_data {
>         int bat_connected;
>         int ps_connected;
>         bool pad_input_event_flag;
> -       int sequence_number;
> +       s64 sequence_number;
>         ktime_t time_delayed;
>  };
>
> --
> 2.43.0
>

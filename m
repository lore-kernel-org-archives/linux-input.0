Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795476526;
	b=2w/39reMEAA88Mhb0LgSB8YseHEZmwa4r7JjzrbI/97KrNYejPNFxZ7kpDes0G8LLoqo
	 6As/aWZ2mZJTccAb6lhuByWd66WNST8w3Oa23IYnMlNAsT+6BPoc64WPMB8YJECEh13yy
	 mg5qNVfPHiC5FgXQj+QvbYQvOSNYe8RjvrLHCeqGoTjsgcQJNXkRc3dY/uLWtcbOFbNXN
	 qio/qokv0L5SrKucD1bUUzCvD3O8FLx5J6GvB//K7je3V6XiToL2/Nuv5Q7VOPagdIBzW
	 8ULmF2gKSEaDNKPvf797qxX0nF1LweM4I7Y2ga46koziDVJgTBJr86z2nJgIE+lDnlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bKupv4Zo0Go6M+vCBLl0876hJYAY+8komh2krb0ldtY=;
	b=20KOCU81eG+9IcOEfeJPLyxJaKwJ0IT8MgYv09D2Qfwd0d7h0Wq57FLot5fdmEq8K457
	 QH0aPyO9YDeh3s/2yXPAf8n/cPVXdZeb/L3WysM5pk6hOWExUzFJ+v+KpbwQmSjWnSbXI
	 RSGMXOmCRAqRwMr6LXdq3z9owRa4ttQ6iw7DVcpaL+vXo9+szKV7exTJitLeCa0fBmncw
	 4xE9wAbOvtJtQqOtwXs6CO3oOt2beDgkbBhHGArECsyOY2AzCcLq0T3Zjow1SBzkB6wJE
	 faFnguHRQEwZa6wqm0LdbPt79OqXQDIPlLteruEricv7EYK5/dly9qIXlsSxUuzcQPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lU0BE+Q3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E510606A322
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 23:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E510606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lU0BE+Q3
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ada7d53082so43615561fa.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 15:28:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795476524; cv=none;
        d=google.com; s=arc-20260327;
        b=VMEKzSYCuZa/yCgsfJcmGNZ/yMqYfTLxWKnZ/0/w79xJDzanARpLQ3EZOmr323lZwg
         1le2aHfmmOEXkiEJHOUSUuyb4pACBrp8KGQcpuw+eJahhsRLG6GAyrz5g/S+HE8slfNp
         nBhYTzJqhNKnPiF0vWvgZ1KmKMHFWqke9UHeQmWW94JCH8M6exwLz7BAFQMC/iBBzzOo
         kq7g8DL631hu8iWsNW6auCHHQ99+UnibZSGbtlvBo7liRRsphZzqP2tiDS2KIWF21/pB
         m/Yy7VV7wsgsd/4XP/g5DySpcCZw8Dbez2BIH7UnsmqcTaERQGncsK/WxT5prv6DRyTP
         G0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bKupv4Zo0Go6M+vCBLl0876hJYAY+8komh2krb0ldtY=;
        fh=h+4GLeoGaAoyAwOtSvlLlZ6McxQuWQAIwblCBu1Zwgc=;
        b=ax64XoX7kqABARfpJf1bYnrlRtPFbv961BVJUqiof9J1ii1sztUQTQ141MJZRTeFx3
         tSPihLe8uPpDpXah0+By1um49V86vAfY4ADpmVqmnuITOeRGhig7KqcaVWDu6PWEVqSg
         QuO2GV7t4em0QOFPkwfvnaeFYyVYROY6lmgQigE8UBuEp3IdOIUPyYEOrIBSSd8nco3y
         ePqwJv1/DFNN6BrgKuhH6ssOMRXYzhZa0jrfKERRWYVFLKZb0nynH0G7Y+sEdRMXQ17y
         3YfTgEj28IzMo6neD63kAjdeBhBHFqUQ8Q+mwLzfr6IoTmx6fx83eQa6/dP05iRJ9kG5
         lL3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795476524; x=1796081324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bKupv4Zo0Go6M+vCBLl0876hJYAY+8komh2krb0ldtY=;
        b=lU0BE+Q3bH5XLU24Jo9BZ+d44+uKfA6vCmbyhboDEIzx8JnVdprBMFU3ueene7Fu9B
         B4aXzI5XOWxGlzbxPXM2PWc0caXgbtmQSsmtJfYHbWo7fzJ9qKapNQHNfQQiK4HYqrib
         oih2csHsVxnBJn2cApSbRvyQRGxiZKbg+7CbiXBMxZWr1NdLaFhtdoZOM6GiyxcYXdsL
         XZOl7bVNKbUGpj9uBH/sfcoGBpvVEsgNVXjMFnARYcWKA63SuPp/knTmr6D5LdUIEIFT
         km7CszZNNJurk3A4+EF69IN7FKx0FHyvvzIpDs6BEfcxeKYM68Mdm9JJZKij4kZ+p7Mh
         AMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476524; x=1796081324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKupv4Zo0Go6M+vCBLl0876hJYAY+8komh2krb0ldtY=;
        b=F76Hsy0X8F2Pvs3bj+glSOyuyAO5ZesFQU2yc6TN/yxa6CbVoobWZCHfzGjkgSNrFt
         nRPKJqNx4nZfiOJ+9/4nd9x9Yc8eQQiqwVyxRfiKf8bH10vYHDqRTBCcWIjm9dmcCYsy
         VVTwkQiDhYGq8UZz/d9AsDjJRbQM9ojqnpYlDWX9elJr46d/9z1nKalEoPXAmzLoomTy
         1dFSZHe9qBVbfNbuQTzdqiAFeM6qTz9ubmWC7AiI+TzyHglRvhA6qWMuoWyMQcp+UEni
         fQa8DlFaRiH6KD/D7NOOqmEUGb38ZGdXCKVm5TzzzduUOAGuIe7KmconBv1O90vO/3nE
         /KCw==
X-Forwarded-Encrypted: i=1; AL+hErG3HoD1OJko+iThK2Byomo1RwHhftfwnWFlvfPAQnixfNIYpUeTUZwBZSxKSM+Rv62nGpSZodSlPSNeMg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8J2CZsJb9fvloVjZbfntlrfWrZzkoFCcmOS0RyQxLA1EZdX9Dk
	eiXQA/02oRGH4LVnl7ydQfvzgZpfFPyNGsQKvOzgw/JYADsHiJa5HQlPXnotnUAthNkFxsZbwJW
	QtU/oyLAJqRaUywDnon3Ej6FE2N9bG9k=
X-Gm-Gg: AZFdTZcZmdMcsn/GiTyrKMRAH75t0fJVreHaVtNxGhcfFrTdmW4ktVfm2SBJg/dLJnm
	HZN71JsmShNpTLJXNFq+kc+3eW+jwFqkZJAnPgppG/zsF4NuSCao6K7EsIyRqGMfUv6XpftW6Fu
	DY2tmbBxglS8S13kFWJVvWX6wWZJYmpqgAcAgp3T15vv+aB0XJVJIEyzPv357ujQT0j1ING2zCF
	5JRmgXgifD0A3MKEJA3gfg8r2mU/djW3V8sYODVouor0MZZxdn+LaC2hjyzBdnQ0Pwp3C8a/+3t
	cuSpKSSUajBXqE3rG7PQpQ4EZj8VCLM2ayzS8JiwFrW9ESHWJE/q8lwhQyh6+aOKhnDZrqUoJd/
	lbR2z+9VnIltSb6gDYlm8Xr6CnGm1nQzhajBBIThW84Befyq12EIOS93J79iEqF5es+TJ4+uL5x
	44BL44l9HiFu0gtvYhzdMEgiTvU2n1NPwxS7d800gQ4EYLLViTmY185i+qmBc=
X-Received: by 2002:a05:651c:a386:10b0:3ac:f9f5:c73 with SMTP id
 38308e7fff4ca-3af977f152amr209341fa.3.1795476523850; Mon, 23 Nov 2026
 15:28:43 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930002133.10794-1-vishnuocv@gmail.com> <CABxCQKsV49CKbvZ2m2556+P=+q-9DSMdanzXk_v-syzZ=uJ9WA@mail.gmail.com>
 <923f7e6e-3e1f-44a7-a3e3-6ef83c148db6@app.fastmail.com>
In-Reply-To: <923f7e6e-3e1f-44a7-a3e3-6ef83c148db6@app.fastmail.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Tue, 24 Nov 2026 08:28:05 +0900
X-Gm-Features: Aa3M54rsftTf6H8DJJpmAF_O-aFo7Zx7CANM618NF8ETZwdFZrVCw5c44AWUHHE
Message-ID: <CABxCQKv3xKs8S=JaFrbpHj0cZRjh7U3Ff2tfGaXqg1ZbfDM2rA@mail.gmail.com>
Subject: Re: [PATCH] HID: lenovo: add fn+F7 display switch support for X12 and
 X13 Folio
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Derek J . Clark" <derekjohn.clark@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Pearson <mpearson@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri, Benjamin, Derek,

Gentle ping on this one - posted on Oct 21, and I have not had any
feedback yet.

It still applies to the current mainline and I have
retested on the X13 Detachable.
Is there anything you would like changed before this can be picked up,
or would you prefer that I resend it rebased as v3?

Mark - Thanks for the "Reviewed-by" tag.

Thanks,
Vishnu

On Fri, Oct 30, 2026 at 10:01=E2=80=AFPM Mark Pearson <mpearson-lenovo@sque=
bb.ca> wrote:
>
> Thanks Vishnu,
>
> On Mon, Oct 19, 2026, at 2:35 AM, Vishnu Sankar wrote:
> > Hi All,
> >
> > A gentle ping on this =E2=80=94 any feedback would be appreciated. Than=
ks!
> >
> > Vishnu
> >
> >
> > On Wed, Sep 30, 2026 at 9:22=E2=80=AFAM Vishnu Sankar <vishnuocv@gmail.=
com> wrote:
> >>
> >> On ThinkPad X12 and X13 detachable keyboards FN+F7 reports the Super+P
> >> key chord, which behaves differently from FN+F7 on other Thinkpads.
> >> In particular giving a shorter on screen display time making it harder
> >> for users to select their preferred display mode.
> >>
> >> Newer keyboard FW is now available, allowing the keyboard to be
> >> configured by the OS to provide the standard FN+F7 KEY_SWITCHVIDEOMODE
> >> code as used on other Thinkpads.
> >>
> >> Detect if the capability is present and enables the mode if available
> >> on initial probe and resume.
> >>
> >> Suggested-by: Mark Pearson <mpearson@squebb.ca>
> >> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> >> ---
> >>  drivers/hid/hid-lenovo.c | 71 +++++++++++++++++++++++++++++++++++++--=
-
> >>  1 file changed, 66 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> >> index 3976d7b53b14..6b4b689c8834 100644
> >> --- a/drivers/hid/hid-lenovo.c
> >> +++ b/drivers/hid/hid-lenovo.c
> >> @@ -44,6 +44,7 @@
> >>  #define TP_X12_RAW_HOTKEY_FN_F10       0x00000803
> >>  #define TP_X12_RAW_HOTKEY_FN_F12       0x00000403
> >>  #define TP_X12_RAW_HOTKEY_FN_SPACE     0x18001003
> >> +#define TP_X12_RAW_HOTKEY_FN_F7                0x00000815
> >>
> >>  struct lenovo_drvdata {
> >>         u8 led_report[3]; /* Must be first for proper alignment */
> >> @@ -557,6 +558,34 @@ static int lenovo_send_cmd_cptkbd(struct hid_devi=
ce *hdev,
> >>         return ret < 0 ? ret : 0; /* BT returns 0, USB returns sizeof(=
buf) */
> >>  }
> >>
> >> +/* X12/X13 folio Fn+F7 reporting mode: feature report 0xa4, [id, mode=
]. */
> >> +#define TP_X12_FEATURE_HOTKEY_MODE     0xa4
> >> +#define TP_X12_MODE_DEDICATED_HOTKEY   0x01
> >> +
> >> +/*
> >> + * Select how the X12/X13 detachable folio reports Fn+F7 (display swi=
tch):
> >> + * a dedicated vendor hotkey (report ID 0x15) instead of the default
> >> + * Super+P key chords.
> >> + */
> >> +static int lenovo_send_hotkey_mode_tp10ubkbd(struct hid_device *hdev,=
 u8 mode)
> >> +{
> >> +       unsigned char *buf;
> >> +       int ret;
> >> +
> >> +       buf =3D kzalloc(2, GFP_KERNEL);
> >> +       if (!buf)
> >> +               return -ENOMEM;
> >> +
> >> +       buf[0] =3D TP_X12_FEATURE_HOTKEY_MODE;
> >> +       buf[1] =3D mode;
> >> +
> >> +       ret =3D hid_hw_raw_request(hdev, TP_X12_FEATURE_HOTKEY_MODE, b=
uf, 2,
> >> +                                HID_FEATURE_REPORT, HID_REQ_SET_REPOR=
T);
> >> +
> >> +       kfree(buf);
> >> +       return ret < 0 ? ret : 0;
> >> +}
> >> +
> >>  static void lenovo_features_set_cptkbd(struct hid_device *hdev)
> >>  {
> >>         int ret;
> >> @@ -739,6 +768,10 @@ static int lenovo_raw_event_TP_X12_tab(struct hid=
_device *hdev, u32 raw_data)
> >>                 case TP_X12_RAW_HOTKEY_FN_F4:
> >>                         report_key_event(input, LENOVO_KEY_MICMUTE);
> >>                         return 1;
> >> +               case TP_X12_RAW_HOTKEY_FN_F7:
> >> +                       /* Fn-F7: switch/extend external display */
> >> +                       report_key_event(input, KEY_SWITCHVIDEOMODE);
> >> +                       return 1;
> >>                 /* Power-mode or Airplane mode will be called based on=
 the device*/
> >>                 case TP_X12_RAW_HOTKEY_FN_F8:
> >>                         /*
> >> @@ -794,11 +827,22 @@ static int lenovo_raw_event(struct hid_device *h=
dev,
> >>          * Lenovo TP X12 Tab KBD's Fn+XX is HID raw data defined. Repo=
rt ID is 0x03
> >>          * e.g.: Raw data received for MIC mute is 0x00020003.
> >>          */
> >> -       if (unlikely((hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TA=
B ||
> >> -                     hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TA=
B2 ||
> >> -                     hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X13_TA=
B) &&
> >> -                     size >=3D 4 && report->id =3D=3D 0x03))
> >> -               return lenovo_raw_event_TP_X12_tab(hdev, get_unaligned=
_le32(data));
> >> +       if (unlikely(hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB=
 ||
> >> +                    hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB=
2 ||
> >> +                    hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X13_TAB=
)) {
> >> +               /* Existing 0x03 vendor hotkeys (8-byte). */
> >> +               if (size >=3D 4 && report->id =3D=3D 0x03)
> >> +                       return lenovo_raw_event_TP_X12_tab(hdev,
> >> +                               get_unaligned_le32(data));
> >> +
> >> +               /* Dedicated-mode display-switch (F7): 3-byte 0x15 rep=
ort. */
> >> +               if (report->id =3D=3D 0x15 && size >=3D 3) {
> >> +                       u8 pad[4] =3D { data[0], data[1], data[2], 0 }=
;
> >> +
> >> +                       return lenovo_raw_event_TP_X12_tab(hdev,
> >> +                                       get_unaligned_le32(pad));
> >> +               }
> >> +       }
> >>
> >>         return 0;
> >>  }
> >> @@ -1366,6 +1410,12 @@ static int lenovo_probe_tp10ubkbd(struct hid_de=
vice *hdev)
> >>
> >>         lenovo_led_set_tp10ubkbd(hdev, TP10UBKBD_FN_LOCK_LED, data->fn=
_lock);
> >>
> >> +       if (hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB ||
> >> +           hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB2 ||
> >> +           hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X13_TAB)
> >> +               lenovo_send_hotkey_mode_tp10ubkbd(hdev,
> >> +                                                 TP_X12_MODE_DEDICATE=
D_HOTKEY);
> >> +
> >>         ret =3D sysfs_create_group(&hdev->dev.kobj, &lenovo_attr_group=
_tp10ubkbd);
> >>         if (ret)
> >>                 return ret;
> >> @@ -1439,6 +1489,13 @@ static int lenovo_reset_resume(struct hid_devic=
e *hdev)
> >>                         lenovo_features_set_cptkbd(hdev);
> >>
> >>                 break;
> >> +       case USB_DEVICE_ID_LENOVO_X12_TAB:
> >> +       case USB_DEVICE_ID_LENOVO_X12_TAB2:
> >> +       case USB_DEVICE_ID_LENOVO_X13_TAB:
> >> +               lenovo_send_hotkey_mode_tp10ubkbd(hdev,
> >> +                                                 TP_X12_MODE_DEDICATE=
D_HOTKEY);
> >> +               break;
> >> +
> >>         default:
> >>                 break;
> >>         }
> >> @@ -1526,9 +1583,13 @@ static int lenovo_input_configured(struct hid_d=
evice *hdev,
> >>                                                 hi->input->propbit);
> >>                         }
> >>                         break;
> >> +               case USB_DEVICE_ID_LENOVO_X12_TAB:
> >> +                       input_set_capability(hi->input, EV_KEY, KEY_SW=
ITCHVIDEOMODE);
> >> +                       break;
> >>                 case USB_DEVICE_ID_LENOVO_X12_TAB2:
> >>                 case USB_DEVICE_ID_LENOVO_X13_TAB:
> >>                         input_set_capability(hi->input, EV_KEY, KEY_PE=
RFORMANCE);
> >> +                       input_set_capability(hi->input, EV_KEY, KEY_SW=
ITCHVIDEOMODE);
> >>                         break;
> >>         }
> >>
> >> --
> >> 2.55.0
> >>
> >
>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Mark
>


--=20

Regards,

      Vishnu Sankar

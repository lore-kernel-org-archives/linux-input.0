Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177638B7BA
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787689814; cv=pass; b=TF5lEmFOIFkl8+D0+9NmVrUuiyKXkQK2WjH0emOyBqlXdFSDvu7JhoAqV6z66xiGjhAPiBQ6udjAUmEE2j93mQTAn0H9xUYOHzt1eGTNo2ozN2j2t6/pyQZxTzP7JMUF1RKvrpMZ/yXLteRaHsQn2xGEFz4H1Y5O/qk0vWSuOAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787689814; c=relaxed/simple;
	bh=cdVAblNBOvonHy/gAlfmBuYSPfGLObggc5W0h8ZfBIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/9IW1WirywJdEbLXHVGaI0Ut6CyYk6IypFRK+wxys4D6E6MgE83QO6U7dT4hkfjan15krIs+Uylxbmm2xnkoDAs/h6drzI69xxZeFAZGUeiAxATofRUNEtDghP6cXAKJ7+H9IJKxq8f2cLrhOqtST4L/HfjdtpBZpyMkJI7NBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEAPXZRd; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEAPXZRd"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c8e2e39easo2965281cf.0
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 13:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787689812; cv=none;
        d=google.com; s=arc-20260327;
        b=GkrTcvUnlRDbM7Fj1SD3QS+cNNWqy2CBWcROPdWjTHZnBm0pv6OLYQACrUpIra6xwQ
         FPUJWjKCoUqYKYS4bmEfHRFCYtnUHusykBPJs3YnkLg6cwK09Ssi15wrdwmxETlAJplK
         CrHWMVuFpeVRpXXd1lQwlUBUNcmrP+mczxap5pYEhtkexTPLUBWzipB7aDLPCqLNg5ga
         Dxvhmf25QhHKFPFze8x9nmwVNzueUOo5u+uMJjSgHN+8RqzHzkZRSwL7o/AeZI5ultFX
         R+3dOn+ea2Q1qnBSEgBvmAorQuQ2ZT/Ele/0NJFiFCQafH05ftBugzPiDmfrW8i/dq8S
         nutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3gSrrnDHJl4XaKdWUdXdWuzwZqfQXUQALO3ll+JBIlM=;
        fh=4DUxt6jiBtSAENE4xyFeGY7qNR//0Bz9pHLOxnRJGoU=;
        b=BOzIetEUXLRu7qP9t4yNzojY/LbB/aPf8bSLI2Y7DPzWMNxlVlU5X9Pnj3ydN21MLY
         lpdaPfUMaj420Qg+M4U+kmMQe35uHENP82H9IoolZaPgU/bJBmZ782p/O/k5XFwdLw1U
         MHPJY5totfXlwwjtJxEjX9nfnIOEwimh9vCgAdGQxzlZXYiIV8gYuoz3fhidqcoArTvg
         fIhY64TZU1ahdgPdWR73P9hsQ8RUwsX+x2qiqh6oc1+JtSB3Px+a/ba5BH18Evzvkleh
         n+qvwOckO9VovLI+cDdo7m4v3BootZmiNAjBjxmu8gLJEWjiQX6pPdkruWYyyxsU9GJc
         xMKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787689812; x=1788294612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3gSrrnDHJl4XaKdWUdXdWuzwZqfQXUQALO3ll+JBIlM=;
        b=bEAPXZRdBpAi0gvKeaatL+1sHth9tO02emCetByOsPwcIP1twRW9vY83ipg8x//6JU
         1tdDSpr4OgocdY+jQPfaX0KIKk0K75doUEkExTDJ9hseJ3v9KL91oiDZKa7vrxlESSFH
         hyRs8dk/bxN9jl2opd9Olf8bSvcjcX6/ZxZnixL8DGeo3mwSxaUS9F3MBqVQ7d+hyf8q
         qGOOpq5MT/5G4clwUkc5ftxOKk+MPRGYPLph1PsVQdk7uKCoN6LzrmSugRDYgB+fS5WY
         ebdM5u5RJQOA2bnEoxJyu3WlmEj9UMwqn52rFHRPTnUntumHsAlCllsO3iyxc22HgGSY
         BvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787689812; x=1788294612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3gSrrnDHJl4XaKdWUdXdWuzwZqfQXUQALO3ll+JBIlM=;
        b=AXUe0zHT66QL22EU9wcl8Xc9GjMM5vrfR7J9jPuGOJWVDvbHP+PJzGZ+GQyBEC9AFL
         5tQTtu8MTwGdT+K+z/N+oe3rcNtc/BnZUNrgg+UYw3oPNBcQ0ZuE5EhmchW/p/ykaPG+
         xwutSSg2DQEz5ICqvQfG5cuGtdm4L6MPxut6fRU8F+3RO39RnheuIdEvSCX2fI+7ncdH
         KdFAxlY+dTotpVV1Jj5lxdITzFcYIh01meQ/3t26eex3s5TGjTiVfZtnE7Z6pY6AWaxX
         IFpkicxaVZMZfrCWY+7CzGtnjq8ybcEWsa6Og6nhS1m33kelI28fXKnKnfV+15IcNa8Z
         Yb+g==
X-Forwarded-Encrypted: i=1; AHgh+Rr6JOnBIx96SKg2wx51Fp8ddXf9XyTobi4VnoZQZ8/1cdXsGeBRowGvYc56sn/8oOWc2uHFpleeGMLTpw==@vger.kernel.org
X-Gm-Message-State: AFuF++lXqkrtaGZUXobsGyIb/9jBP7Ret4t6HEVS/moh+zV6XI3BLSa9
	uQ/L3vSHQyrDJsMLV4Q5RVDasjZjE4mbktJsKttlWXuCep7XS5YzdrYisjqV/SA2m95E9rNsGu8
	J11wpzc7oB562KEMve7h7Gn+6V030ezkgnz8K
X-Gm-Gg: AR+sD11LgkIHKjZebrGU05edGGUM4uCnjUUuaUPZ+lQ0tCR0AtswmdaV4Xm8eDgMjMB
	QUpZhOEVxCRj3/4DQGz1kK8Ok04cGSdE+mmhWbOzJeVSdbarY+dKiVbHmkAb1JF5gEdGjwUvlS7
	vDN6vtxtAMGyfDWzX5aJd5byg4+36mh1sZPiJTNQz5VkPZ5L5Dn+t9+JTfJAUKRkAIeBLe2SEPS
	xTHC+FVN10syxMaGdcNkNyDUCc1PCQ1wEAgA8N38q+NH2DrL9iEFP+GRP5zZTPX+IGmmpFmN8a6
	J8wHYL1ZSZFDcMubonHCjv9QRSD3E7TJCxw72MjGuxaYLmYmjf65lkjt
X-Received: by 2002:a05:622a:230b:b0:52e:92:1398 with SMTP id
 d75a77b69052e-52e423df37dmr19131451cf.26.1787689811946; Tue, 25 Aug 2026
 13:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821214810.87826-1-mradityadash@gmail.com> <20260821214810.87826-3-mradityadash@gmail.com>
In-Reply-To: <20260821214810.87826-3-mradityadash@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Tue, 25 Aug 2026 13:30:00 -0700
X-Gm-Features: AcwNN1USPoglZmieAMZROTbWwdoIXfVZrMLjdG-UX8U_uQff8lYN5OadhbOgJ_0
Message-ID: <CAFqHKT=jEGuDrR0Ci-ybJ-QZrr=0oejr-2hLjEKyvPnxUCvS=w@mail.gmail.com>
Subject: Re: [PATCH 2/5] HID: hid-lenovo-go: fix the FPS mode DPI request
To: Aditya Dash <mradityadash@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 2:48=E2=80=AFPM Aditya Dash <mradityadash@gmail.com=
> wrote:
>
> mcu_property_out() adds the five-byte request header used by most
> configuration commands. For FPS mode DPI writes, this inserts a device by=
te
> before the four-byte DPI value.
>
> The FPS mode DPI request does not contain a device byte. Its little-endia=
n
> DPI value starts immediately after the command and sub-command.
>
> Use the four-byte header only for FPS mode DPI writes. Keep the common
> header for all other requests.
>
> Fixes: f0bedee60607 ("HID: hid-lenovo-go: Add FPS Mode DPI settings")
> Assisted-by: Pi:gpt-5.6-sol
> Signed-off-by: Aditya Dash <mradityadash@gmail.com>
> ---
> The corrected FPS mode DPI write was not tested on hardware.
>
>  drivers/hid/hid-lenovo-go.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index b8248bf8965c..a6e9a130ad41 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -725,6 +725,11 @@ static int mcu_property_out(struct hid_device *hdev,=
 u8 id, u8 command,
>         int timeout =3D 50;
>         int ret;
>
> +       /* The FPS mode DPI request does not contain a device byte. */
> +       if (id =3D=3D MCU_CONFIG_DATA && command =3D=3D SET_DPI_CFG &&
> +           index =3D=3D FPS_MODE_DPI)
> +               header_size--;
> +

While testing this I go some strange results.

(deck@lego2pro device)$ echo 1800 | sudo tee fps_mode_dpi
1800
tee: fps_mode_dpi: Input/output error
(1)(deck@lego2pro device)$ cat fps_mode_dpi
500
(deck@lego2pro device)$ echo 1200 | sudo tee fps_mode_dpi
1200
(deck@lego2pro device)$ cat fps_mode_dpi
1800
(deck@lego2pro device)$ echo 1200 | sudo tee fps_mode_dpi
1200
(deck@lego2pro device)$ cat fps_mode_dpi
1800
(deck@lego2pro device)$ echo 800 | sudo tee fps_mode_dpi
800
(deck@lego2pro device)$ echo 500 | sudo tee fps_mode_dpi
500
(deck@lego2pro device)$ cat fps_mode_dpi
500

compared to current:
(deck@lego2pro device)$ echo 1800 | sudo tee fps_mode_dpi
1800
(deck@lego2pro device)$ cat fps_mode_dpi
1800
(deck@lego2pro device)$ echo 1200 | sudo tee fps_mode_dpi
1200
(deck@lego2pro device)$ cat fps_mode_dpi
1200
(deck@lego2pro device)$ echo 800 | sudo tee fps_mode_dpi
800
(deck@lego2pro device)$ cat fps_mode_dpi
800
(deck@lego2pro device)$ echo 500 | sudo tee fps_mode_dpi
500
(deck@lego2pro device)$ cat fps_mode_dpi
500

Thanks,
Derek
>         if (header_size + len > GO_PACKET_SIZE)
>                 return -EINVAL;
>
> --
> 2.55.0
>

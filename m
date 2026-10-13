Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B7418A22
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863849; cv=none; b=O4bznfHt+BFGSuRzYV2+tZZl9ZKiwWqX2zgpp38wxpUBDJPEP5khh0bPCMjsuE906z2uigDikPQYWXZPLIOFA5XCWW8VDfasiI4kODC7N6hrQ7OB50JRzGBcVE7z9sErFXLYZOVgX7cGrVfrljW0fxLlMnSVjP0W0QqZVsq8yZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863849; c=relaxed/simple;
	bh=OeIO6VMigs7d/xgMcCyP5rHCxkmMqBepMJamPW7F4x8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=b8bXP6pPuoIIruRVaB+TiJT0mIg5NdwxrD+V7UmCdg4YOd7MsMdlhRttUt5JSUqDSht9E9hEHiLkpBoumwlnxLWR7aVe5fl4etMc7MhvJCOkniB4gox46VmciHOZC07gWStP7i8IRbwGdMLQtuh55v7yCALEFEeGu4huVJf0UPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP9vs2Dk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP9vs2Dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6371F000FF;
	Tue, 13 Oct 2026 03:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863848;
	bh=H+C4cMGMB3N1cbQM9EThefWMV0FtVuhvCr+0+EojygA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QP9vs2Dke+xOvQ3VL4Z6VfBkBxB67gTrYEBgBfsSUIoRjYYZuO9Zi7FF41Axloaub
	 xJ4HQ2Qsp7uDZsnc8TGUrYIrOQquZTA1uuJVy/hAbDPORbSRILJUImbvq7aOO92jLT
	 Q94bWiHLja5i3mYT1fC1cn0izaIN8yAtv0f7YADZPateoQoqBy2CJwPmbo18pYp/+a
	 iVFRayhNPzRNZFWra4+qK+oe5BJlaVOkTAcLqS46VNu5uYEdYc30i4WRBQFsWApn2V
	 FAokzrHHwUw+/T2iKgOvMwUi3MqRFeOpheoe7Q7LkMD4kWb2RTKlA0hP0gp4CE5e4O
	 aB+y0UuTIDfuQ==
Message-ID: <sashiko-outbox-168943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] Bluetooth: HIDP: Fix GET_REPORT and SET_REPORT for
 unnumbered reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261012-hid-core-report-validation-v1-1-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
 <20261012-hid-core-report-validation-v1-1-e0dd5cb60b2e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:57:27 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bluetooth: hidp: skb memory leak on timeout in hidp_get_raw_repo=
rt()
--

commit 9c135d466dcba28a7f3598e00e865c9ade48ff0c
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Bluetooth: HIDP: Fix GET_REPORT and SET_REPORT for unnumbered reports

Adjust Bluetooth HIDP transport callbacks to adhere to the kernel HID
subsystem convention of using report ID 0 for unnumbered reports. When
fetching or setting an unnumbered report, the report ID is appended or
stripped to ensure correct lengths and formatting over the control channel.

> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index f5bdf9f1ca638..004a8eed51fb1 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
[ ... ]
> @@ -302,11 +302,25 @@ static int hidp_get_raw_report(struct hid_device *h=
id,
>  		}
>  	}
> =20

[Severity: Medium]
Does this code leak the sk_buff if a timeout or signal occurs concurrently
with the device response?

If wait_event_interruptible_timeout() in hidp_get_raw_report() times out or=
 is
interrupted by a signal, it proceeds to the err label, which clears the
HIDP_WAITING_FOR_RETURN flag and unlocks the mutex without freeing
session->report_return.

Concurrently, if the device response arrives and is processed by
hidp_recv_ctrl_frame(), it can set session->report_return right as the time=
out
occurs:

hidp_recv_ctrl_frame() {
        ...
        /* hidp_get_raw_report() is waiting on this report. */
        session->report_return =3D skb;
        done_with_skb =3D 0;
        clear_bit(HIDP_WAITING_FOR_RETURN, &session->flags);
        wake_up_interruptible(&session->report_queue);
}

Because the error path does not check or free session->report_return, the
sk_buff is permanently leaked as subsequent requests will overwrite
session->report_return without freeing the old one.

> +	/*
> +	 * In case of unnumbered reports the response from the device will
> +	 * not have the report ID that the upper layers expect, so we need
> +	 * to stash it in the buffer ourselves and adjust the data size.
> +	 */
> +	if (!report_number) {
> +		data[0] =3D 0;
> +		data++;
> +		count--;
> +	}
> +
>  	skb =3D session->report_return;
>  	if (skb) {
> -		len =3D skb->len < count ? skb->len : count;
> +		len =3D min_t(size_t, skb->len, count);
>  		memcpy(data, skb->data, len);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-hid-core-r=
eport-validation-v1-0-e0dd5cb60b2e@gmail.com?part=3D1

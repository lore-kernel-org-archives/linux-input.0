Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03AE3AF656
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361629; cv=none; b=TZ8s8CsqUd4TiQgc5C7fE8u4djGHBEGQkw5MleI/vGnaE2oF4pKwf2vUm3QfNNSah49BLQuTGDeKAgPtGbP6BTpUUtEBLhjVG/Q3iC2g/8pEHB5Mx5+kJhEZHXerXoK/LLWfynApBH2yFpwmVv3EjO/TIeMiHlCHqoefDrKUpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361629; c=relaxed/simple;
	bh=VpFolloZdgNmH+zY+zPPB3tEx/arXXg2F9adDF3Djik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=geay3muSN4rOESoNuKQHmMbkysm9jgh9XE/Kozu3i9xJ36tICk+60y6Aw28E0KVueqWjncvsAs9oFQehdFjp76uQa47pkU/7vZfFudS9dm3uKOJlsSbukSTkDJmlo3Zg9o1FqhxUcgPCqkMggoktWdwKGwk0mE/AxeSMw2aiWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQzmpU4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQzmpU4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700DB1F00A3F;
	Mon,  6 Jul 2026 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783361627;
	bh=FmmLVdCzSIuZbNTJZErvvwotFs/VwQfVUXsu14/B264=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YQzmpU4iOEMJRX0In88ELcZ/5A5Rq8gHMj7hSCsaqxLQdMtjwe621bvU/DO27le8l
	 JzwstwyyWC6ht+lIv5WdlXOvJ4ndCrdsvlnn1LZs2lyGFvpZ214sJ3fLKrCRlQlxFv
	 1l0fsMSFuMUPrYhkrw0nFIqbUJo1uUf2XMREEZ9ZCcBPg2jA9EsDfqq0oh/sbe5hvm
	 /k8JnP+pLgQ7tD+rb0S2eBzDE+1yLQwfFtviX9/82ilCzhMTvpQI5+44/OH3883KIo
	 JvKcD2s9AEnV6uw4wo4ImD1TilsebpSOx19roCPxU1CpY9zd4fOLcOYs0smQSCJVKA
	 2a0xOv5V3+jcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: magicmouse: fix battery reporting for Bluetooth
 Magic Trackpad USB-C
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Fed" <andfed.net@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260706175507.47288-1-andfed.net@gmail.com>
References: <20260706175507.47288-1-andfed.net@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:13:46 +0000
Message-Id: <20260706181347.700DB1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unbounded recursion in `magicmouse_raw_event` when parsing mal=
icious `DOUBLE_REPORT_ID` packets can cause a kernel stack overflow.
--

commit 58987e236bab550dc05b66346833ee21ed261110
Author: Andrei Fed <andfed.net@gmail.com>

HID: magicmouse: fix battery reporting for Bluetooth Magic Trackpad USB-C

This commit fixes battery reporting for the Bluetooth Magic Trackpad USB-C =
by
avoiding the misparsing query path. It introduces a battery quirk to skip t=
he
query and instead fetches the battery at the end of the device probe.

> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 802a3479e24b9..0c4e959322c3c 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but while reviewing this file I noticed
that magicmouse_raw_event() doesn't seem to enforce a depth limit when
recursively calling itself to parse DOUBLE_REPORT_ID packets:

drivers/hid/hid-magicmouse.c:magicmouse_raw_event() {
    ...
	case DOUBLE_REPORT_ID:
		/* Sometimes the trackpad sends two touch reports in one
		 * packet.
		 */

		/* Ensure that we have at least 2 elements (report type and size) */
		if (size < 2)
			return 0;

		if (size < data[1] + 2) {
			hid_warn(hdev,
				 "received report length (%d) was smaller than specified (%d)",
				 size, data[1] + 2);
			return 0;
		}

		magicmouse_raw_event(hdev, report, data + 2, data[1]);
		magicmouse_raw_event(hdev, report, data + 2 + data[1],
			size - 2 - data[1]);
		return 0;
    ...
}

If a malicious Bluetooth or USB device sends a HID report starting with
DOUBLE_REPORT_ID (0xf7) and filled with the sequence [0xf7, 0x00], the inner
size byte data[1] evaluates to 0.

Could this cause magicmouse_raw_event() to recursively call itself with
size 0 (which returns immediately) and size - 2?

A 16KB malicious report could force ~8192 nested recursions, which might
overflow the standard kernel stack and lead to a denial of service panic.

Does this need an upper bound on recursion depth or an iterative approach
to prevent stack exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175507.4728=
8-1-andfed.net@gmail.com?part=3D1

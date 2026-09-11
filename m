Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC8446AEFE;
	Fri, 11 Sep 2026 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117502; cv=none; b=cFEMpEoHYXF7sVJ5JKe2ROiwLN02MxGWt2CAw8lH3lUOQZPYFV3signnnPGBXxLkA3+CVCD/xFrD7Gvcnv0/g2oD46jMhwQU+E0Y8a36tDrw17rs83awyAS6pbcmgFv5GD+NHh/Jey6zdWSGXBGCDkD24yovteJZirhGhne2eUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117502; c=relaxed/simple;
	bh=FvQ0WJXKhilnzUZTfX6OBSl+HEm6Y46X5aJ7DHFEkHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i6eIEU3qtYDlm+CVJyfnTqyTq0eg5SQTV7gEa+7p6bxpRb0K6OxaU+cW8W5wxTLZxgvbsjVulvov8C7t4y4DWd4payXmAZh/+eV5iaPRoNNl6fKF+xBAl7jV3Uu9PPJmS54WYoZo1oCOwGcENIJ4nKDF6b/BYOr+dXtvc+GLhyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl0qs9WM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl0qs9WM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046D01F00893;
	Fri, 11 Sep 2026 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117499;
	bh=FvQ0WJXKhilnzUZTfX6OBSl+HEm6Y46X5aJ7DHFEkHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bl0qs9WMGfI+o+/T3U36gv77DmWfhrxgReQIyNpYUoSoHUqCsNn0UBorhw4cZNiOe
	 5/1aoRK6eidZlSVbM5UM43avMHyKMosZk94OYYBYEJiFSUhIWUvcRccGQbzkapEAlV
	 anWR73FiNmMO/Kn0R5ybgCVLKpGEfbVF+ySGexdHurMrt5iN/Lb5mWBwjBn/NwEZ19
	 fM7242UknLCMqt4ib1FO/doh5c+TaK7s1CrZurd4qZIiDnCwQK0H6JH22nd4PMHhv5
	 8fguM/SVBqF1E5axCQu5c3LKNHylHCF0zcWFobQnmECGHhOiwBFz+k5P/eK0t2dPzl
	 xmFM9SCugmYaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/10] drm/msm/dsi: separate host link enable from
 video stream enable
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-9-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-9-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:04:58 +0000
Message-Id: <20260911090459.046D01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>
>=20
> In video mode DSI displays, enabling the host previously engaged the
> hardware video engine immediately during atomic_pre_enable. When panel
> prepare routines transmit initial DCS sleep-out and setup commands,
> concurrent active video transmission causes DMA timeouts (-110).
>=20
> Keep the DSI host in command mode during atomic_pre_enable to permit
> clean panel preparation, and start video streaming in atomic_enable
> after the panel has completed initialization.
>=20
> Signed-off-by: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D9


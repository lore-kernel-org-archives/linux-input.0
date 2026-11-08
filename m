Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794126837;
	b=JrP/q6E7nzNWodG7ROxI5Mxd4J522n64voREt06+si91K/TyL1BOrBqd/ALmKuE+9v4Q
	 nUbSSEUoE54xlTo4WbgCdBsSCPIIoBQCKHBD9WbA5yH2D1bjMsKWdWUKGhwEYMVncNlxH
	 +zQDRY8MS1kn4GS57SRxhYWzi0uQWU5gqNebnbNE1XmqdGjnxhYrjcyYmBoh+9dkhmbFp
	 axpP6aHYKUa5iiMaFpvfnPpvA/4FyiXDlCfMwBhKvp0e1cBAVWVPk0UHR0hyjWm+fznDF
	 TSbjtP24t9WRsov8nRcOyelQFL4D+p28KlUSeWsuOfT3FC9l1w/pbGk9GUOON/bQ8kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126837;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TWqxygLXpWua4SbflV3fSAej7Qxp7eAhvNfS7Evogpo=;
	b=AYNGzTFkxVdT6qC0ZNDIpaGe7uKpW+n/5hodKWzj+NFhfUXwEX3mU7sjHzsxO9xBYOFI
	 4zYBkKL4ZrfeW02Q3bCkxFN8c0KQMHpwS/lBGpGIsMuPj6frE5RDUTIt2RYT3p+8Vnkda
	 f4toWoeOl2NG/5JtjMfqgpXgTiL/RBFCokXVjhgWR1h5gbdJ/fna7jwfpkgzGuafFh8kH
	 c9BaX9SBZJyFsp0Tr7EtaZf8dYthlnqyDz0aJtAwDHElSNbsS8jpHs77GfTUiAL1FrzCW
	 +5hoQZ/MSwF5/21K6JtbDizlSuYQ+ejM9vSNAWh7dIxFrhzvDzaW1YO/bJnmuG1DSTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVIeqac+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33967606A320;
	Sun,  8 Nov 2026 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVIeqac+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794126836;
	b=Iu4/SP+I6KvlpkR9EMbjIPGL1ypNxVUrFf9h7x5k17gZETae2RQ4OFVscLugwqQtCRrI
	 aOwoHuXIqZ/yzMobg8w1iyBmoEWDO57RP+cIew8IQgVQ8nnKz903A3wkYabJZcd7t0mtt
	 +9lYkUMJUXX2hZwptTf/gFm+87VsVVF4vRXWiJiIvoia9HIatbVyFtwqChkRqey/OW44A
	 UXkL5VGxsoRQFqHfK2uMaxD4Hw44nXwb/xO/7ycNJO9rbAuenUFvAtWSyC/MluZY9KjoO
	 mRE8pPVS1MOBlte+VBLfJ0603o7a/uWqspHPtpYRYCCdFrEMNXjX9oFK8eqnKgJ0ieg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794126836;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TWqxygLXpWua4SbflV3fSAej7Qxp7eAhvNfS7Evogpo=;
	b=UqailBHaDbSDYP6GdvMtzN8jFFm0YKT9u20ht4pbJT5bK4JQE7Ig58rczu5enZJfrx3e
	 Kpt7ZVg3RydkzsDQfsSMjwnUVGZ93BLdE5DXOd7wB6khbeQbrZpbSmA5/I9haM6FOg/4V
	 roO9AweLhzwMlk22EHavbIBpcg/ZLfXY2cyc5KMBIIP+V/WgkjEu4GeY6Dfelzirl0ogp
	 cQfzqVdyD/HS3PxtgcwkNj1XceCJbLUC4cZ5a/iSQJ12ZMiEKYVeS879O2frn9I4hzYQl
	 2qX4vTwUlMyqIq+8S+Vuv3PKdwhpaXc9Tja27Qg2sZTYv6oihPqPPkePz1JYVm5zPUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 490751F008A1;
	Sun,  8 Nov 2026 08:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794126836;
	bh=TWqxygLXpWua4SbflV3fSAej7Qxp7eAhvNfS7Evogpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VVIeqac+7fSwUA5CeGKoaLQI6sqaiSxAXa1e5bxwZsFVeE3fMAhgRQPd+eXLUn7yd
	 PGGdHj72mTCUIoPrKKCTg3DRbhzr2x8IFHjJR9vsdUID3S1SpUHXlnIRhRWzWLCTT2
	 BiKPpol5H/QeRAlY+PuSFfrHf3jGF/Zw75tFUyfWkrHWmM14YbygTDs6utOEk7DnL2
	 peXIaxSCbtKEnHaC/RzdWkI244nQgQSYrVxH7IB6bZAcnvMGTNt/9hJ84vxZW6iEdn
	 j1ONO8zGpah3MyYGHZw5ux0ZOlvayBfXgtjGYqsWYiq+bvKPGJkq7eD8sKsRboKuzt
	 fjyLko4dfmIhA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BF03247E7B;
	Sun,  8 Nov 2026 08:33:55 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Sun, 08 Nov 2026 09:33:53 +0100
Subject: [PATCH 1/5] Input: s6sy761 - apply the touchscreen inversion and
 swap properties
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-b4-s6sy761-fts1ba90a-v1-1-999b3cfaf82d@dxdmail.cc>
References: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
In-Reply-To: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794126835; l=1311;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=/HYbfSgZDXp9Nhf0xICDcKIqRlQIrJcsLDH8yaqlolc=;
 b=WIBweEs1vzSWji5B+Q5cDYE8grceEaquTXhxFfb0/alutLPE7YnHAt4Lx3W4WDVhOmm2JtScd
 X6OGbbzr7oMBF3zTfjRRNxXHtSMkewgR9CYtYaNvaT/ws1BunzLaSR/
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc
Content-Transfer-Encoding: 7bit

From: Nizat Mikayilli <nacht@dxdmail.cc>

The driver parses the touchscreen properties, which swaps the axis
ranges for touchscreen-swapped-x-y, but reports the raw coordinates, so
inverted and swapped axes do not work. Report them through
touchscreen_report_pos(). No in-tree device tree sets these properties
for this driver.

Fixes: 0145a7141e59 ("Input: add support for the Samsung S6SY761 touchscreen")
Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
 drivers/input/touchscreen/s6sy761.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index 1afa38850f12..967fd222f0d6 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -153,8 +153,7 @@ static void s6sy761_report_coordinates(struct s6sy761_data *sdata,
 	input_mt_slot(sdata->input, tid);
 
 	input_mt_report_slot_state(sdata->input, MT_TOOL_FINGER, true);
-	input_report_abs(sdata->input, ABS_MT_POSITION_X, x);
-	input_report_abs(sdata->input, ABS_MT_POSITION_Y, y);
+	touchscreen_report_pos(sdata->input, &sdata->prop, x, y, true);
 	input_report_abs(sdata->input, ABS_MT_TOUCH_MAJOR, major);
 	input_report_abs(sdata->input, ABS_MT_TOUCH_MINOR, minor);
 	input_report_abs(sdata->input, ABS_MT_PRESSURE, z);

-- 
2.56.0



Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184498;
	b=pLCHSUiNur91VwaIC30ARAP+t1EcG1aq9opL43etNkC1Xp/ReVYwaogp89WaAdGkHx+X
	 +hiDpk9pF7Yy5uJdDKcCYaPfwZsCf7mGZl1dUHBMjr5r9hjqHhKhF6H9Cz5sjZF/cZHbd
	 qlnbhFuvWRlrHW5OSpdyUKWMmlyYJzqRPaWWpeDClwyo8a53769xrFp2roRas5Eu98fhV
	 dQdwAXnBQPDU8sSjiXKgmQU8FggKkVp0J9HsTisJEFiQpYrUpX2fb9oMfYDPO/gwtlRFa
	 IMCCcXREuSfHqIoYwEj8aWPV9wgCY4TH1NztoC+/vUJiQXXkb0p5F94/OyXc4+XErGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184498;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jtbsYXE9pi8nNVitcFPDgpxB5EkBqeu4XL7i4LvtL9Y=;
	b=pu10x1z4/U9wkgWCANcU40z3/l96hEEaaCf79+IXbWCJPMCFSaO/w/StQpLVdocQIu2Q
	 hhEpDy7izeWvPCiUEQeHxb67ERJ5cvP3XvtInSdnwov/9Pq7F8R0nwetFf2toIDga4aD1
	 auUVm4bhYKsU5jcNhcVvpkzbLYqMzYzlMcvE76EirFheX1GQx4N85VOSdvXRNoY4i9UVQ
	 R2ri0YYef0LhAoNWL2dzsfR1Qz14n8dYFnv1dpNsZTtkn3ujqZoqFwLaE7eMj9GZEvNRC
	 r2WAIm7k9pj3/FGpiGZae0e6LafFRJ4oVwb0gjCDIjvbH9MqbWjuTCNm1wXmkWT/L+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iXIbPk1C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19240606A324;
	Wed, 28 Oct 2026 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iXIbPk1C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299BB1F01825;
	Wed, 28 Oct 2026 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793184497;
	bh=jtbsYXE9pi8nNVitcFPDgpxB5EkBqeu4XL7i4LvtL9Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iXIbPk1CHnz9B98EGJcvdjTSRmUArBwBHRQ3NdHKSKjaAKf53295sriEqnMqrhVMd
	 5gy5/2O0tQCEqH4KDRP5NzKV/wSIni8filrgpcxXhtI6POgM3UWUDErGRCixmnoMSo
	 xhthmj4lUbozKlrFpzm2CSf7zM904DsGcWvXo+T9Zt8foYoNSAhT1z2JadQjHPtRGf
	 XA50Q2Ongcnvp45ZkWzI2F5a4vXwPmu7KcuI+CGko6xj1nnGBgn3rey+RBbwvmKn0k
	 LOtJWNbGr/pVXmFytJb4hYkY6bhwsLsEjXM1n7UFGg0hIf1p02bxVE5zsPekbNy59X
	 h+XtRLsTOUl+w==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Shashikirana H K <shashikiranah@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tzung-Bi Shih <tzungbi@chromium.org>, Sean O'Brien <seobrien@chromium.org>
In-Reply-To: <20261013-upstream-vivaldi-fix-v2-1-ecc20329d24c@chromium.org>
References: <20261013-upstream-vivaldi-fix-v2-1-ecc20329d24c@chromium.org>
Subject: Re: [PATCH v2] HID: vivaldi: Extract feature report value directly
 in vivaldi_feature_mapping()
Message-Id: <179318448985.1921288.5630625275501815196.b4-ty@b4>
Date: Wed, 28 Oct 2026 11:48:09 +0100
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793184495; l=453;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ssC2BEqqeJsgFahgFghAg4DBFN8kzDswfNZJJeY8UoE=;
 b=B5TrjKDWlobmsAifxRvzpucosReoWiQGyxBzylh7/UScpCoHksHC1zm7+5rd3Arnl+4XfOgGC
 y6LaKobIfjKAoggcFexz293/1B245kHKWQj2MUyABGidiXhyPWv+HrJ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

On Tue, 13 Oct 2026 06:46:32 +0000, Shashikirana H K wrote:
> HID: vivaldi: Extract feature report value directly in vivaldi_feature_mapping()

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.4/upstream-fixes), thanks!

[1/1] HID: vivaldi: Extract feature report value directly in vivaldi_feature_mapping()
      https://git.kernel.org/hid/hid/c/8dbf66b01113

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


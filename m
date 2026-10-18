Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4543F8B6
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320398; cv=none; b=mBBHb7demSQmv9LbM7BI5f8r78/LLknBfX+/V3yQ5/tZwMRT6+q5zPZVR90Cv67aUCIUeXfnlhb18RIhdh67ZTupcILtLLdOLNO28OJXk/j0wX378ukYcKqnzO2NMs7FAqzbVM8Vg2k9G79NSz2WrpAtNboeW4Q+SLGtgAfHqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320398; c=relaxed/simple;
	bh=SQ/SYrXh+5CwEvrwpxtX23+FbGxGlYtGDGs1ObPCCVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNfDDzsTU7sx/NU9y9R7ol1x49J85i9c84fVut5OgPILLJEJeGdKoK7tJdZveU4QqJKC/hnecNltZCBYxXJ+2iKZ7uFMthKpMFzOoG8ct9KQlH4uiqSBbhAuxvpeNfp1FTUnsyhaJeGP0jEIkN/us77ejS37PRitDvi80dsZy8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OibLzQWa; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OibLzQWa"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd623dfe420so969352a12.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 03:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792320392; x=1792925192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3dVKKN3DPlm8bXuDignnQ0HmpnRMQ+D7u3OnuhG2rs=;
        b=OibLzQWaL0sxmeyFrEvLsDzlVKemXLdZeCQuQFPHTnGYElO+6bQf1FqHisHrRIoCQJ
         1L8UcVPU8+t0I/ehHhAex681Sh8Z2CwLDO8K5s9S1lTylCYUMdJ0DkV4WB5zLzxG3Wvt
         JYYaxSJ3bMjJCGS0jZSjmRYN42VtJYV4UEQBhRVB3EE02bwnpgycbdwHAws9l5ELv4et
         q4TD8muxM2va7YHfgFW1qonMei1ZL6LZ+0kr0DWI3FOSH3jbJgprEUNvTjP2YenVUXGv
         bi8rkvItU2nF4AYcPPcS0EQrPnkgvf869Rv1bhKseNkZSw5ZhvMq4Xoukg9NXNq+SWwc
         ZZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792320392; x=1792925192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3dVKKN3DPlm8bXuDignnQ0HmpnRMQ+D7u3OnuhG2rs=;
        b=BxN29Tfk2PoBoCj05EhBKR2j/95xezygPH0isSaNn86nEYHyJ69oi/HqcjnlIR8X+b
         kU2jM0mpaZsYulrEoaX4Ocqs5cL4BGhV2Bw7Bd9o7/rXPeSDFjofv6SdiISIFj+dk0Wl
         TmTITxsypvHYMxyXNiiMy0Vv1ddAFYJYxfBBMc05fQVT6OL83VkSMvUoPGNemgD5XvZN
         7baoAhOkaW3NanSDIyn5zwO6ETImTP8Z5AxA92KIHTsNBPr/e3vFz9TyV1545dnyhDYs
         vpYE14uhZyHKUECkgQGOYZGY00PQBOjV2faXh1oVB9hzL9qyNG93h7n/4VSsG9yV6IhA
         BWHw==
X-Forwarded-Encrypted: i=1; AKwUvBwe+bPRTItfUOHvL42GYDBCxCeMI1iBpYD6Oos2Zhwr+xLqj70BNmlHJnNfadoSCC+Cj9prXnxbhsRIkQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJCrbJlUw3muw0c0laI4VRX987UdcMa+g5fQjeONUEcxUZJzmUP
	i8TKi5FrbH8LLs1mgSHPIbWn5yxhuCotiiSFr44gv4/RtF3161F1Iqup
X-Gm-Gg: AYBFou3ByIn+ar60EWS5xafuqyA+agD1ZNGV+fo4sLKyIis6dq5qnlfEXDzX0h5mrO0
	rYyc9AmvLUwMvvIk3XsSi5psMpaephHMv76CD9q3PPK4rkaup7d1SpXbMwHf1Gx52tix8hPzKws
	eJNsdy6p3xjEWqUOhdU/RrrkMaq5EsCrcWpNw0P28oXlOxLuxVpNN3ihzfR0ArM7s+D9fs2j7hw
	G6eDXN+zUwA3AHXwN7nJYakPzS3GV/gDgfhV4pNkIWn2DwAeFI2VebW2fgQ2ed3wcNng4pKX5Lt
	fZQzbEklpqC3XQcdJxA8mx3ofBrYasA0p7545fSnUQW0DWdC1hmvApsQO7Khownt4GyB0DUZwVe
	zXh7atl/fPYpLS0TsQApSM9DTtBjkrFUU3zYzGERRlQe6mwwoZufu1XSRuqPRo8Qo55q18CpphU
	EVqcUN3QSdx+SWZk1zAEhD9WhJP1kd+w2Reis5NuwhOuobCtkTtTDsAga71lL733jOcbmKYYdfI
	RSDAS/OzOLii4MLwYYxrxI=
X-Received: by 2002:a05:6a20:cd90:b0:3e0:d4eb:a9b4 with SMTP id adf61e73a8af0-3e2263d3801mr3823884637.45.1792320392419;
        Sun, 18 Oct 2026 03:46:32 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a33681sm2949085a12.29.2026.10.18.03.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:46:31 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v2 3/5] HID: wacom: add NULL pad_input guard to wacom_intuos_pad()
Date: Sun, 18 Oct 2026 19:46:15 +0900
Message-ID: <20261018104617.743771-4-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018104617.743771-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018104617.743771-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_pad() uses wacom->pad_input throughout, but pad_input can
be NULL when wacom_setup_pad_input_capabilities() returns -ENODEV during
a successful probe.

Place the guard after the data[0] report-ID check and return 1 so the
report is consumed. Returning 0 would let the caller fall through to
wacom_intuos_inout(), which would misparse the pad packet as a pen
event.

Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/Cintiq")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index aa08afb3c5ef..acf24360d547 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -578,6 +578,12 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	      data[0] == WACOM_REPORT_CINTIQPAD))
 		return 0;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pad_input is NULL\n", __func__);
+		return 1; /* consume the report to prevent fall-through */
+	}
+
 	if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
 		buttons = (data[3] << 1) | (data[2] & 0x01);
 		ring1 = data[1];
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876105;
	b=w5jmdCaGp5hBrmX1VwV16o2YkUt6dGf4uXjrdJhaXPyTlKj57iiQXrFpHbQku0zXCkFe
	 8cYmYse+zV3G8BsU+kEt8MvLx4Gk3hIErPpRaUtj7uwK7tNKleSuE011ltIeqmwLIlDOy
	 TsHOvZJHz2PEoWGOyWqNk/RuA2LVTEIWF1peheo+5LBj9INjWIAUs42lYeSYLkQ6Nt3Y9
	 7aQm29q6Y7I9xmy1yNYdrmHOknPXhHMw/qOQcUGJvV0aP/xxUIjRkpW23wf7hpSvmDilX
	 pl/gkQ0muZGymNyq/Vk9NQSWgEN/LXzTCgKRTftMe1pbv7s81Rh/xvpIgrVClo6lXYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876105;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uGUhG/4kegYC9lMeZbNb8t81bDNVOH7gztwwXEebXhc=;
	b=257d7SfuXbBqAReXWrTSe0/bs+RnpUao5siJfjQreu89TYO6DIoj4HugLOSXqDEqQbeG
	 WtgD+Rhb/T1opknfwMdGKxvcKWkw4YsQJcELmlcQk4RX8bxAIit8vlQDD4D2WxUcPcPw2
	 UCvOSfr+6ibHpq9Iett3yiDF44d8AEoHN7YhGAB5pKeF8LQUZCQzvtzZ0CYZw/fWUkS7F
	 w2OykmWyYD9H9vO+uMdeZrpwawdqbsnedNu2x7EfgucH5ie9mT0E/U+HtMUTRXKsgD2rh
	 aYtTG7GTkH7j/DXZLCxIkJXdvRzkeVnfeW1WveuqpWaS1Dbiq5lE34IXctpE/vzPGmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ust6rJ5E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D35606A33F;
	Thu,  5 Nov 2026 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ust6rJ5E
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793876105;
	b=eX6ulAtxJSezZS9Uw7TEjZ1c3buOtr8XFgV6yrX/nHyfiFULlT8X8k5f3LlPupe5Gnbb
	 dW6s8XEXp6LtENKwmObvZE8gxHkOiZ/xl40EQyXWROCHW5BodvQgP85QHLuK9gzVG5JUU
	 rYTkpF4wee822OjZurKP9r4kv5yFYtMqPQjSH44BKcLtEWXWEzryIn7BG3o7u5uhpPKNw
	 eZ+VYqpxq0Qf9LZjgDYBhXAqwYi4Sl2+ufmQaj7ixxWJUiLPTmSh9XT5mpuRxPdGBtdAz
	 XOIlLFpFyqBo5K1GsNeoqnJYth8V35IiaA47WjHe/hqRDZedCc8Rw5+BJgGqkH/psnQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876105;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uGUhG/4kegYC9lMeZbNb8t81bDNVOH7gztwwXEebXhc=;
	b=P0q5t3SngQHsPvwKV9274YHKYEXLJVV9vVOX4IIbTOy5SQNmTVM2EGrk6fc2fYUaPy2l
	 9zh4pU/wWCDIpU1fmeNpL/N2zlGRjMJ7lo6ALvV+iSGAj0I+kbxnCIfAxqGVPtX4Ez2sE
	 Wi/brirYFW+fOmzfCnAXp5yrfXsPvoleEus8s3KZDXsDrI/kCGZq09a9fSuwTva6wmwnz
	 TuGKjd75c51rn0rbiHDa1QOV5lmPm7agOefY3nNOiUXzmkxC3p/K+mlZ6YxqBIBShM8HH
	 BaQqnDwNf6yEaoM6mb86I/BbyLZcVUPsYzqqgU7x6Fkh7wRRiEOYCtAqLWkUsvzJpCA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9072F1F00A1A;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876105;
	bh=uGUhG/4kegYC9lMeZbNb8t81bDNVOH7gztwwXEebXhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ust6rJ5EirVnRu2jw8iP5TYRMxGGIT0dfmvlwwAwdBrOFn4Ztnv86AjVtysyDut0d
	 Ddfwu9IuNgxi2zJOIhgqFo+3Lp4kLx1zxUBxOAR4nI9P+K7lM6fKO4J6fS34ETT/Z3
	 J2ElLguJs4r2hnB38RzSWJR2SAR8a6ShmM1TOOeVNy2KcInqQrJUrWBoCOdEyj49h0
	 r4Akiwr+PmQO/m1+OsPWLxPLvybIoCKZN6QRDoRintwu1AlS7FemCEeomi0mQr1tyk
	 w4wjFze2E8PoejThgEy3b2QWN3leQXoRoR//qNxxJz308AMYbfrZI8wglkX+1/lmPx
	 JZ0ufxBTwzzWg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1E954471E1;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:07 +0300
Subject: [PATCH v8 03/11] dt-bindings: watchdog: qcom-wdt: Document MSM8952
 watchdog
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
Message-Id: <20261105-msm8952-initial-support-v8-3-311ae8e8f14b@mainlining.org>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
In-Reply-To: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=902;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=CVXmuzbvh1yrXvbAPQPnGHqHjpewg6nuUS4b1kM2YZs=;
 b=/1yNGZLtQnjGcwViYL3Zd6KAb3MfgFAi2DskVQ7c03EGd1LGGUNpaKWXPtvWcvzJYp9yHUAN5
 HzCxj3jpdJGB/1sGwup2eYb03eWzzYzpzMLqbvaI3PFtXpW/dZxzWss
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the watchdog found on MSM8952.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 4ff61102e407..38f86ccd1ffd 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,apss-wdt-kaanapali
               - qcom,apss-wdt-maili
               - qcom,apss-wdt-msm8226
+              - qcom,apss-wdt-msm8952
               - qcom,apss-wdt-msm8974
               - qcom,apss-wdt-msm8994
               - qcom,apss-wdt-nord

-- 
2.56.0



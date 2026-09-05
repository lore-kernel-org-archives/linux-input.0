Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4613CC334
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591841; cv=none; b=cUe5PymBqgrsjKcQtg+y+RWjjp+vF5/4s3DgGsDXFaAFyFgSgC94PDNBHWM2YU6VTsTusfi++VCKyk8yv6JGJeXqbN5ETp8P2qORvOecWQRR8CtHnxsZv+EnoutEQIFITn5cIGwe8z0xX51UfWHaeQXweME8VycyopCT9tNitVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591841; c=relaxed/simple;
	bh=cYocdUbY67Nl4dIpxLMGG57akBMxyeedBoJqIxiyUr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ka8Cp3CA2U0lnn74JnLei2709q8jCVsN65OaT9et3+PAbGpYhyTAhEakdQSl0I+Kn23z8hwar0jq9NOOpmZUCGEPw1t2U2qgT6RT+6YYykELC4nQQy+Dy+KvzKPbunHB2YxZ9izhOD9dz/jwcdH3wlrEy8vKUkWwHOW5VD+BiCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sS8A+LZv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS8A+LZv"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b965570d7so20648415e9.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 00:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591835; x=1789196635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mRF2sj6EV0Dui3NmrAkRlrIYgvCUUxE0IVt3jvr9R7k=;
        b=sS8A+LZvQz0V8qLYy+YYcWwHbpnZThCjCqaGdb+U5pTUuv/j6+Ede4J+MgzUfU5LHR
         v2veE+CpAN1YERMqnENv5lKtWGG+uq6h2NDD0TZLbbS7Zg6avN94OJLTqaWF4NhjBDhF
         I6ler63uYLrzlFTb0je0e6QqxXwrhCuRkJPv68i451b13VPxF3teoU8nzot1PvfEgcJ4
         cVuoZA/mRtCVDwtkUYWqtuceSXlAj3AHCyNBogBMHvvcu+9YAM6nlbSexzN5R+M4Z2Pq
         qtJycT6ELRz6UTCJk2t/COvlSHbNjwqfI4bV6Et01e2yyhUAoWzmVCRKv4sI9vWsLhXr
         vf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591835; x=1789196635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mRF2sj6EV0Dui3NmrAkRlrIYgvCUUxE0IVt3jvr9R7k=;
        b=SmZSbKBqCntkCaK8iw9EBwQiSLAuWHwA/iac9CjD9VK9sduyDUsPgb+OmvKfoFxOyl
         ZOVZtB05LAo5cK0xfi/3rTQ/iPiGBt+5iZtMhlzzb0UpCgbYDjkUnlTwJNRJkLaNzQmv
         Aw+gCf8cJLARw60DMFX+VY4mcSf/aPuuNU5708qdd5DVdU56FkLHAbDgzVYbWXS+eRoK
         VkhhRxNhc4MZS3lWqerBoh157oTcuzwgoRaLB81mdGF2baPcZvV/Inkf3WJMK0/ebDI8
         NuAYedUikwyTcWcgnWTc27dEZeXCe9iOMXQEJdzjlHCn8viGBzQIGD3xIeHYYWpU3oFm
         QNDw==
X-Forwarded-Encrypted: i=1; AKwUvBw9B19jrlSlnXj81QhleIiXoD0qy3COZCT/FA9TFwdFeYBMSVOEzRoT09d+WkEeQncNio7Mad+5RPxhBg==@vger.kernel.org
X-Gm-Message-State: AFuF++mjXvxU7PDkcM1+WwZE003ZnucYLrWBscCr3UKOWtFkVM5DkGh/
	nU8HsoJZHmbwbR/LYFT4sqzUeTcSgZJmbmNUdit4hZk9NCfahE1fueur
X-Gm-Gg: AYBFou1/JkEVzzUFOBzQEZEYmpKjJ0S53WR3ilRnWRnwOdOpsHZYwKH2mSLHIwmxr5x
	GrylVdMs2VLw/Jk0UA5TEk8lb6W6DP+882xDWf4PxfwHTsAHE4/skd9pz3bfrR/KCO+hQOk6NYW
	FSufPivx2ITzEACuCrCKgVjDSVPFw4keaU0gUS595D4qenooOQlZWnVxE6b1pp0bA5Hd2cBlPiB
	X6PQil4vwiNTWni/2t8qNg+NomuIz1VlMjJEyFH5vSbl8ky9JVK4z06+cHyujERvmHBA2OgmtDX
	bBoLN3AGIbOM0MTX2cGblqO/RACNGw5tIGKjNeA9Y8iW6ZgzmsupagKUkRIjw715l7y0Y6OyhKb
	1Rb+Z1RCaANbcJxzUX7bBJKhXHqyl3Ke9+6blOpa79sJLsAYGNFW0bfJkLYorH7/ESLrnpiJbZO
	2vdjhNkMMBZTioY+elz3YcosLdpNFNh9sJwuslH3kEovmpyYiGVz7QmkqRFECL2Z2BdRmwymZZy
	t3TtPnMpfcBk3IOd3AQSpFdZgXmvqq696ZjvUNSP9zbVUCs/4YMZe25w1xy2YYiZqsSwP7rBk4A
	WmmllETBd95nEtKMz5r42kU9wSGbz0bX89HdcsHX0EawvpKuIwOMHVOMx0339vjIQ2pDWTe1
X-Received: by 2002:a05:600d:864f:20b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49cfc6e8ed8mr59365875e9.33.1788591835143;
        Sat, 05 Sep 2026 00:03:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.03.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:03:54 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH 0/9] docs: kernel-parameters: Remove ten entries for parameters that no longer exist
Date: Sat,  5 Sep 2026 09:03:38 +0200
Message-Id: <20260905070347.25902-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-parameters.txt still documents ten boot parameters whose parsing
code was removed with the drivers or platforms that used them, one of
them (atarimouse=) since before the git history. One patch per
parameter, each with a Fixes: tag for the commit that removed the
parser, so the maintainers of that area are on their own patch only;
the two pata_legacy module parameters share the last one. Each entry
was checked with git grep for its __setup(), early_param() and
module_param() handler and with git log -S for the removing commit.

Karl Mehltretter (9):
  docs: kernel-parameters: Drop the atarimouse= entry
  docs: kernel-parameters: Drop the bau= entry
  docs: kernel-parameters: Drop the edac_report= entry
  docs: kernel-parameters: Drop the enable_timer_pin_1 entry
  docs: kernel-parameters: Drop the mini2440= entry
  docs: kernel-parameters: Drop the nomfgpt entry
  docs: kernel-parameters: Drop the omap_mux= entry
  docs: kernel-parameters: Drop the pcmv= entry
  docs: kernel-parameters: Drop the pata_legacy.qdi and
    pata_legacy.winbond entries

 .../admin-guide/kernel-parameters.txt         | 67 -------------------
 1 file changed, 67 deletions(-)

-- 
2.53.0


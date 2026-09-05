Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A3391E77
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601629; cv=none; b=erR/hVzn6qRqGZtscGbjQ9XhGoxevBgWyAhatOmX62610KBE0TBYaZf+Xy8EsOoAeFfqsO30dxnfJ0kgaAl/kvm97zlm//X3yoaCrjiQOh7u/wIQnbVm5M2N+rjcRiV8BWo45sbXW4dl7Ig4MRNO0JP86Upk28yeaTXv6ijAMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601629; c=relaxed/simple;
	bh=r1zTAstGx+IQRZSz2V3LqeUHrdmsIckPyGpER4pVwcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GNPVWm8+vvU2iAFIEIM6GiFB7rhvIH44T5njE+W4l2kkS0eFVyyiU/wKC3R1QwqsVKI+EgCS2M37oSxb5HOlaDRomLv9bC60sW5ul/TexzO7PNxMRvTtpe69atKJ4GSXwD38kU12eKkJc9GaVxuQaJ+ck1xy6c2uz84rPk4LaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mqzc5uFI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqzc5uFI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b8687630fso16356525e9.3
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601620; x=1789206420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0rL+/iAM/i65sRrJdGWBjEYqO95wvZ81bUVdK7eRsAk=;
        b=Mqzc5uFIvQMGJH/Qvx9JF0IzrPctKlDeb9yowyBBnvUHbJf5jBARJGIOZJ45uNB28k
         8Z4q/bv2SqU25SFGtZ61Xd7F777i2Dq9EaTA/Zrj/rZFEXnioKAWjArU0Qu7i5h7gHXF
         Ner24Ov6fTQNGs33qhIXnkra+vE1dBm7taglV8UME4MALkC9WK/JVUhq9u+mXQj+o59b
         wKASP4FMp090Fsvh9lvAmn3il43ycNJs1EMS0myNTLfxMK+UoErDjiHTKDGPBw0vwUq3
         KnFQWL1E5SlZeG2rkKaJMNU9CyAE4Ob48i9+WHPenGupCpxuQvAs1KuJ5+jSwkCkwIDA
         +G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601620; x=1789206420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rL+/iAM/i65sRrJdGWBjEYqO95wvZ81bUVdK7eRsAk=;
        b=hz98RPlW91p+K95SGixVBp45ZmDpcdRxfHNBqN3rHy00TI9o7dQi931yaAHqzqaqyb
         plI4IrEA0LT5G/3BT7tfwZ8jHKSBBYDYaJvgmjQqHup31p0hN/1XJGs31l/yiiJGA0c7
         Qfa37D8Iezd4uhdK61mCPdWkTFNUnbuBNtFVVoVkW3FHiXyOATA2ytsdXAadd1yZMHXX
         PuYxb1JQ+pey2OFr+KHn4Wn8nmiOQ+/G4BQi13ugDpgnG9TMrmYNt4rgorjZBJevy3PH
         uIc3P9fcVavW9I+eP6q2q2XsYs5B1Bep9wniHFs7wGYrBumnY69KvYiu9QeIkEcpJ+iX
         zd9g==
X-Forwarded-Encrypted: i=1; AKwUvByf+Ju+jMp0d4wouTUSKDVs/D/XjpA9YGM4R5nGPLhVkMvtwYYccCCNxiLxm96cwKYcST0ciJHaeowqEg==@vger.kernel.org
X-Gm-Message-State: AFuF++n5sH2WdDFUKsNYkMl8yZdfVTffJD+na17SH4gZFsJ/qT3WTQmU
	Iy7xVBRhC1cTBnHjmczIxrLMTbimVozThEwjEdMPa4UFFg7o0S1iBC/0
X-Gm-Gg: AYBFou2CbHBffdhqGnD9e7jVnwQwMgdN1S24jFP9EQkltXjr1gxm7Z70g8CbWjQX/eu
	xJy/yNmHm2nVemE/4JK9eDLMwG/4jMp1WAkJbbRhjMQ+UxxrWHBHWMeVlpdHXblzmQqDtBOJHne
	nPxQryNPknApK6hcaSnM47a0SVmF6+KJ2Pi/DlrVAeKG2UHXptBIzpSmEldT3oP+z58+IkNMozG
	9vjc0qvQn35EnMFySTUAkDozT50g4QK5rGdSVTsyLt3HRVzwVSLtkB16Jgnr8eDQ7gDGfAed08e
	Vpjss6gtQRQJ4g3cQ/3Bv77IsF0IaEDJhlKml6UI1j6zO/z5G2GfxIhLSNFpWatVWtNeiSfXpER
	TnylxvaTmF9huWklTqb9x3CvWsjLwFiQFtHWWVVgBcbDyBzqN9VXi7cXgO6w105I/S4EOOlVdN3
	J4QG253Rp1GuQr0wtUnrB4AJtgciQh3QATolEi19/kk8UenEtBMMik5E6bNfHG3edXefF2Tpj+E
	SlJQ20WxSSMSFUdd6TTxM6yPlE/8gmVRXk+cYjfYSFmgWBmgCngvSw8lUE0MarFoLz5NNySFCGP
	vz7HhlouIdSOvuN9xJudTs737OqM8wdpuo+e3zcK1F4sOmokTU+u3Nlv1PzIfzfvGtg=
X-Received: by 2002:a05:600c:3e0a:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49cf8267a36mr138818915e9.12.1788601620145;
        Sat, 05 Sep 2026 02:47:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm14232013f8f.25.2026.09.05.02.46.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:46:59 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Mike Travis <mike.travis@hpe.com>,
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
	linux-ide@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/9] docs: kernel-parameters: Remove ten entries for parameters that no longer exist
Date: Sat,  5 Sep 2026 11:46:40 +0200
Message-Id: <20260905094649.41996-1-kmehltretter@gmail.com>
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

Changes in v2:
- patch 9: drop the Fixes: tag for 0dcd0a76370a, which removed the
  separate pata_qdi driver and not the pata_legacy parameter; both
  parameters went away in 3c4d783f6922 alone
- collect the Reviewed-by and Acked-by tags from v1

v1: https://lore.kernel.org/all/20260905070347.25902-1-kmehltretter@gmail.com/

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


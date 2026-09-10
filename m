Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B882930D3E8
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003974; cv=none; b=bG9J3YifFlFfmzGqYJkVXG7BSjcXwXu4f4SwaYX8gCzhr1tVBb5+dcfaHVgliWVvCzBv/QdzGDYdjCIzP0nI488Ka4nY3AHUoPciqgUSlHLUBdwmmk20m0AAKCQieLEjkFTwl51trghu1Ia1Gnk8F3qrvBJAB1YuSEYMXyOYxWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003974; c=relaxed/simple;
	bh=XsI6Y/1sSLQp0adjnMZsyD3THyVMp5IicuC5nSeg3go=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCIShLs+qfp7hqt5fTy3jYUkOwetV+DqTmsxAYzG3d3uExg+DMln4ZR4egwpNAK7HfEhuT7T+6lpacpzAFQAU5hwM2rbEe1Y3tsGFTPioWUc5oX3TUozGGlMGUZgUaJAaeJb8zVCYlDG4JNHwcbOdKx36ufIoFf4L09ga0krAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3/zSNQH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3/zSNQH"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4957eefd361so51355025e9.1
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 18:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003971; x=1789608771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VrhRS/M7q7pkTrLXrhmPne9tuf4NOHwrkARE6eFwxWk=;
        b=I3/zSNQHQXeB8cN8Wwdu7tgpm0DIv77z8BL8iakzEHX/aunQ9Aw1ymGqcisbz7I44r
         AmrhDnkhRnxwOe2nRq82G9aTLqH5PKybIWDSrtt2l/oOTuUckZz/HVgwFVqwFnJhonk/
         KbcrASX8VriPzIaNWBxPPyIwLQa6J1aSLOI6+UfnTRQvhgIYFJS8Lk4uIzt9XuKdk86t
         IDuYkMM8gAIceb4+l/GtrGeE8CNgE4cfPc4CKtExerkOlBut/kwHE4lo2aoRGcYiHCFg
         Kmg2iypyC1oQ02prBHKYBJmPDU65cPy+qakEPhe1I5zyqJS6K1WUzJY3LdjU8EwjXHLG
         ghVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003971; x=1789608771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VrhRS/M7q7pkTrLXrhmPne9tuf4NOHwrkARE6eFwxWk=;
        b=ik3Jl2CkrWt+bCBwyq+CCcsw4gUHhPe8aN4OEZmjCusTmaFRlZZlnkG+vEHgTBbNwL
         riOhNuM7cAooMcG1M0M0vnLKZZo9ygJrkVd1s+1MOX6oPpyWp2OipvuqldvPDHhiFdPb
         48OlhE/WM7UMRRMIvmB805im9NFdQGUj/KNX5IUlgSX/KXeS6QDn8jz2y0jSrWU5SGsg
         ZUmudWaMCoNzQF9Ow7ev0/2kuLt8ttQD/88TET/wF0ivScDcfCCYjzPy0Mhr+6jTHv/c
         ELUWGdZx0VWSIOLEI+o7U/13pM6CBSHWqyjyORDw38aXHQvdB2rrrtVYQlxAb5IbUpV5
         32pg==
X-Forwarded-Encrypted: i=1; AKwUvBxsWlflQgUnH88OjqSi4hR5If0UgJi3dBbzc1ohRhBN06Oc2VW+GRoLj4nIObcFqbcxqN5dLJIwebsBaA==@vger.kernel.org
X-Gm-Message-State: AFuF++nYqLVPlgqwDhDQF3ce7lw10YaI3j6KYIU4W143MG9RvIT0nead
	pA+YASmFBVkQbPsHPew67lFMHzqYRHCA49vZifmY4OqFcbv5v+1pXmrt
X-Gm-Gg: AYBFou0auZVy2HokyHMVmKmYNgU2ODI9JIlIYOHdSMmtAIxHd3cFQ/W/QmmOBt8CRfF
	nSLjtzz/5lx4oJlYJpCJcyrEqR07FnqmcT5ZabUsGaYeESVXLiO7snZxCVtxrZ/lmedbD4raF8X
	GZEAPtc6hAi8q8K84DyGQNWk8G7WcLjpww3OCyQ7EnadmdIY4oWn5WoDyPiW5dCTbIMHr3WI6+m
	kn0JxiJJ84QShCoPksnByLE3F3uhPBEj3ieZS/HqgeLnYB4sZ4nmsbT8QcHjSFpHTOQy1IEBbtw
	EdaVg+v//WIGBXbW6d6Z3KvhuwipxcREkaDPFU6gXhruSqdyaeKsJA6hkPdpggg2BXycKAv7to2
	9lf+PxrWJxGl13vN4mCDi9VOl5g34bT81fsBhnqimWYKdKDbgU0WuU03ThbZMOqTjp2EOETYOts
	5RxPGQR4aWeAa8SSqbXsZFXotnBHjD91+DTqeHIIlzawwoPTOFYtnPFRFgTeN+TsReDCR8BWNfS
	vcleCSfoobqCAl4xTIXylVPva8TTTEXHWh3nbkKw4YV+bn/Tk56XsbgMUBoFQej/16ScP+3XEQT
	hTtdO898txtObeYinzeTvViGHYfhCv/Bytlu4J39zOrC10m624QxsutNEJdRLC4z6DY8p6JC92y
	4Gg==
X-Received: by 2002:a05:600c:4e0e:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49cf81e6063mr368280035e9.2.1789003970778;
        Wed, 09 Sep 2026 18:32:50 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.32.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:32:50 -0700 (PDT)
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
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/8] docs: kernel-parameters: Remove eight entries for parameters that no longer exist
Date: Thu, 10 Sep 2026 03:32:37 +0200
Message-Id: <20260910013245.8619-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-parameters.txt still documents eight boot parameters whose parsing
code was removed with the drivers or platforms that used them, one of
them (atarimouse=) since before the git history. There is one patch per
parameter, with a Fixes: tag where the removal is in git history.
Each entry was checked with git grep for its __setup(), early_param()
and module_param() handler and with git log -S for the removing commit,
and the name is absent from the whole tree at that commit.

Changes in v3:
- patch 3: name the commit that turned edac_report= into a module
  parameter (fee27d7d9788) and the one that removed it (7fc0b9b995f2),
  Fixes: tag moved to the latter (Boris)
- the pata_legacy patch is dropped, Ethan's patch from June covers all
  six parameters that commit 3c4d783f6922 removed:
  https://lore.kernel.org/r/20260607064053.195166-1-enelsonmoore@gmail.com/
- collect Reviewed-by and Acked-by tags
- the "Found by cross-checking ..." paragraph dropped from the messages

The remaining eight patch diffs are unchanged since v2.

Changes in v2:
- patch 9: drop the Fixes: tag for 0dcd0a76370a, which removed the
  separate pata_qdi driver and not the pata_legacy parameter; both
  parameters went away in 3c4d783f6922 alone
- collect the Reviewed-by and Acked-by tags from v1

v2: https://lore.kernel.org/r/20260905094649.41996-1-kmehltretter@gmail.com/
v1: https://lore.kernel.org/r/20260905070347.25902-1-kmehltretter@gmail.com/

Karl Mehltretter (8):
  docs: kernel-parameters: Drop the atarimouse= entry
  docs: kernel-parameters: Drop the bau= entry
  docs: kernel-parameters: Drop the edac_report= entry
  docs: kernel-parameters: Drop the enable_timer_pin_1 entry
  docs: kernel-parameters: Drop the mini2440= entry
  docs: kernel-parameters: Drop the nomfgpt entry
  docs: kernel-parameters: Drop the omap_mux= entry
  docs: kernel-parameters: Drop the pcmv= entry

 .../admin-guide/kernel-parameters.txt         | 54 -------------------
 1 file changed, 54 deletions(-)


base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0

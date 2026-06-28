Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82EC2D47E9
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782623497; cv=none; b=hUrcz9bSjQKHw7YdVGgxackseOJvLeXfq8LSsBp1C4V/16+Eie9oeb9/Ck1YY0ZviV2gv8LXsBwJ89b1E2UlrUQnBDImbpmks9D2akrA4Xw8K/KPTPI9TNGN/lYRDQsh62VnVTOmD/MtKkUICWW9G8YZx2f9yvGHhMCjFgmtelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782623497; c=relaxed/simple;
	bh=bSYleusCHZ0QyyO2IrNM/PMBcF4xrI6PqFFbXUozNm4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VaFi5uFlz+9o0nCq7vmTd4cam+PmpewdQWpSvbQxOotzzhAtue3S4WwTrE7R2txB1q/UYSix9Dw6GdUEegFDbXRcEPGMlFlA3zxY0ZGZ9MSBrxvP5EBPaWBijBAseC6BgM1YYoRRBUYE+tWroLSuTubZHgrEWlpn7XF8khSGorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxbZFmf7; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxbZFmf7"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30b6dad2382so4463686eec.0
        for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 22:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782623495; x=1783228295; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a89Djl+57FpDQgfH1zvXXAXdoXloeM6dPQEBvdj2AmU=;
        b=RxbZFmf7ngUjMraQPrqyWhKYeyUmUiJnrhw5pySwGtGvpG7d8DBA9smqN0NOlb9LCx
         8TMaHrbRX0HndizWFOgneAnNne8crwO7nGkQOCdYMoyHgON/fs6FtSWXeRbo1lLnln7y
         2SBBtEXEeVsrouS2f/iiQjulIakvvLfIr+pxGqPqqo0iIbVdBby4gr7DpzFkFafJnpsn
         nYPIrTWfPZp1nJQidYLfyk7ZizXzbySnuqsxlHVUrlkITtSlix7y88gQpS8sjNa3KPXY
         SaDuLVy0KcFR5//JHaye3cvQb6EeQ+TkGa5rbSzrOpgRMoz6ohFaNnqowOJCORQp/YbX
         JlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782623495; x=1783228295;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a89Djl+57FpDQgfH1zvXXAXdoXloeM6dPQEBvdj2AmU=;
        b=fZQ6mQc6Uc9hbklV7L0Q+edl3PhsAeqrjE8Z7hZvQ5JZ12jmysu5RBxUvOztRwlcLV
         KzCgo3DFB5aSU3oPfuzgdacZJXrmZYKaWFk1teySdIXmN6TP6bIloj+PYMTXML6BK6Cu
         fNAwmwMuKMQ57QExhIm2A6HewXsfPTn2HFoMxkVowUsNan0JwAKltFVSktyU70YhFpFe
         vEXKk/o3ndThc1F6LUFWnkn7bDv61aCwTB2T0Y/bq00SG7AtHIOR1OfKzz2oevKJ2iU/
         N9a1ngFLcwHibzADWiNzU1L66rGyL7bUsECpPtFgWvYwgmJbZrNYKiOFUCjBRI7ZN7mZ
         1u2A==
X-Forwarded-Encrypted: i=1; AHgh+RoiCEznX1Bz6pX+XT3QyejZmobMkWRETND4/o73U2n5O/wBMq6uwyaCnSKVSCIXhIunBYrx/1J07AACAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgWL4O+c/7JF3pleAlIokMo9vY0Y4sy9w1M+HD3hd79Z6yikZr
	pHHty8dvp70iiaJvycRFu7xMq4YlgQuk7Qcl79zaI/SlbY4d8thYbIOPsBKt4A==
X-Gm-Gg: AfdE7cm7GG2DJd+LUbSeYujqzQRJ3Qz8vtZdYYBZsVrfaH93L47Y38grAzFVpjJn2f0
	1BGWg7ONQuuLv0yztGUlt5S07ZJgc2b3A8VJM+PZEkDlgjTYRMK5wGNw//W4wIyxqgiI5wX6855
	rJCJnPTczs2zvIp2eglXq7A9kjVNRv9RSGheMlNLljAIefA1ukqWdwKbnHLslKeH+TFIiz7JpA/
	EEjAQwtgFJtQ0xKJT6ZR/BztCrO63Ia1g9GhM+HhK1MoxUtUL/ttAXIfb8W89EETiKkyl0eVLZ8
	J3NVD8Zjqf0wyYHQ3eSNC5yroIYCA/uU84KddygnEkniP14oWMWlcDLIJ96ukdG7BqgHkpOq2pE
	GpOeDIzh96sBUh5VPozDUe+EZHxJZPORW5vPwZDI2NuE4/g904diG30Bxs/al399aqv1hxwkNpZ
	SrlUd0FXJ8yu7/IhCoHLFcNcVJghEuyMTVEGiPPgZ123DUzOpXbLahmQ==
X-Received: by 2002:a05:7301:9c95:b0:304:e587:5063 with SMTP id 5a478bee46e88-30c84b6f548mr13698620eec.12.1782623494751;
        Sat, 27 Jun 2026 22:11:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:977e:876b:dc75:9723])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30d3af0d2e4sm12598283eec.22.2026.06.27.22.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 22:11:33 -0700 (PDT)
Date: Sat, 27 Jun 2026 22:11:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.2-rc0 (part 2)
Message-ID: <akCs9sqkWvpJnCpK@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc0-2

to receive updates for the input subsystem. You will get:

- Updates to Synaptics RMI4 driver to fix potential OOB accesses in
  F30 and F3A keymap handling

- A workaround in Synaptics RMI4 to tolerate buggy firmware on some
  touchpads (e.g. ThinkPad T14 Gen 1) that report incomplete register
  descriptor structures, preventing probe failures

- A revert of an incorrect register descriptor address calculation in
  Synaptics RMI4 driver

- A fix for a regression in HP GSC PS/2 (gscps2) driver where the
  receive buffer write index was not advanced, leaving keyboard and
  mouse unusable.

Changelog:
---------

Bryam Vargas (2):
      Input: synaptics-rmi4 - bound the F3A keymap to the GPIO count
      Input: synaptics-rmi4 - bound the F30 keymap to the GPIO/LED count

Dmitry Torokhov (2):
      Revert "Input: rmi4 - fix register descriptor address calculation"
      Input: rmi4 - tolerate short register descriptor structure

Xu Rao (1):
      Input: gscps2 - advance receive buffer write index

Diffstat:
--------

 drivers/input/rmi4/rmi_driver.c | 39 ++++++++++++++++++++++++++-------------
 drivers/input/rmi4/rmi_f30.c    |  2 +-
 drivers/input/rmi4/rmi_f3a.c    |  2 +-
 drivers/input/serio/gscps2.c    |  1 +
 4 files changed, 29 insertions(+), 15 deletions(-)

Thanks.


-- 
Dmitry

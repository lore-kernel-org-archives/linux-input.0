Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5E3B7751;
	Thu, 14 May 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763313; cv=none; b=f0egc8ZZFJdgsygeETGWDeeidCP9dMtCGiExBRQbVMZC5c2ZBZIk9eiJryClEBMffjDXu1fETsDzz40CVViR1C4RO/UJC/yEspLkny59GrVmDXyYOGI56tVYAUDsE65LdNlhvsbowq/znQoN0Q/1pJZyxOh9MG8Rmq64j4SJuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763313; c=relaxed/simple;
	bh=R2t0di01B7IiAPYXrJ61RxVCrP5SjfJxu9Q9JoPmbn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqL+I1lSWBQznuxbE8uzN25S/fZ/X5vEf9YUc/cku7ndvoRIl3M5PNPj1WY3/T6/29A3fwzOTERS+73IxcT58R69rFjlbErY5sWok5jbTMWriZMol3CVS4Lnc4iT8nYL0/zQ4rugV0yxSQYuIu1GHLnYxydrGKH85iq33scZgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mJw1PL6y; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mJw1PL6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=IR55pZOgPCqctlwbFYvY0nce9ffmKnIV5qqL9Vmvnfk=;
	b=mJw1PL6yYzauOwyuX3XACXFvPQGihiK/73G/dGURYKsVAoo1dcY10k8PDaC1B4
	RGPJHYKkq05n45LTYugxoOuYxMYvU6gYB8QrWf0hTcVSPJVa8tsmbOgqhF5NRHK1
	STcwHigOof+sXxF10m5BFD79N0IOQWr/yMWap4z37jTKc=
Received: from debian (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBngcAPxgVqBLFkDg--.2110S2;
	Thu, 14 May 2026 20:54:40 +0800 (CST)
From: Kean <rh_king@163.com>
To: sashiko-bot@kernel.org,
	derekjohn.clark@gmail.com
Cc: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	mpearson-lenovo@squebb.ca,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	Kean <rh_king@163.com>
Subject: Re: [PATCH] HID: lenovo: Restore Fn-lock LED state on resume for tp10ubkbd devices
Date: Thu, 14 May 2026 20:54:25 +0800
Message-ID: <20260514125427.3195245-1-rh_king@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513222748.D7A5FC19425@smtp.kernel.org>
References: <20260512142229.4098386-1-rh_king@163.com> <20260513222748.D7A5FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBngcAPxgVqBLFkDg--.2110S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWkCFyDCFyrZryUXF18Krg_yoW8Xw4Dp3
	92qw4jkr4xGr1rZrs29a109ryxG3y5Gr4UXr98WrZ8u343Gr1fCF4Syr1YqFWqkrs3Wwn0
	vF4jg3y5X3WqqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRGjgrUUUUU=
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC4BCRQGoFxhCWsAAA3+

Hi,

Thank you for the review.

Regarding the potential issue you raised:

> [High] Unprotected state modifications / TOCTOU Race leading to Deadlock
>
> Could this new call to lenovo_led_set_tp10ubkbd() cause a deadlock during
> runtime resume?

In my initial testing, I performed system suspend/resume (S3) cycles and the
behavior was normal — the Fn-lock LED state was correctly restored after
resume with no hangs or lockups observed. I tested two scenarios:

1. Normal suspend/resume: suspend the system with the keyboard attached,
   then resume normally.
2. Detach-reconnect: suspend the system, physically detach the keyboard
   during suspend, resume the system, then re-attach the keyboard.

Both scenarios appeared to work correctly without issues.

However, I realize my testing only covered system suspend/resume (S3), not
runtime PM resume (which may hold different locks in the HID core). Your
analysis about a potential deadlock is reasonable and worth investigating
thoroughly. I need to:

- Test runtime resume scenarios specifically (e.g., autosuspend of the USB
  HID device).
- Verify there is no lock ordering conflict between led_report_mutex (held
  inside lenovo_led_set_tp10ubkbd) and any HID core locks that may already
  be held when reset_resume is called.

I will run additional tests covering these cases. If I can reproduce any
issue, I will submit a V2 with the appropriate fix. If not, I will follow
up with a detailed description of my testing methodology and conclusions.

Thanks again for your guidance.

Regards,
Kean


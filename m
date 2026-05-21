Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62E360EC4;
	Thu, 21 May 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377026; cv=none; b=KFtKylUwYybVpgYkXloQy++r9WqUBstB6ZsnVBCOZ6d1+ba3NR8vXFWzhn3XiiFmpPByMCM9KORCnHvfWT/FJ94ANsICOzxjw080ebnPtLCQrnBiBAJc9Yb9CH2fkU/aJsZ4HfwrXBWQtuWz7RBLpg+ftbztX2e/tZPd52mc2mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377026; c=relaxed/simple;
	bh=VuWOrCHzcjeMGVGyLjbC9DZovoaFf70YlDCeSRRSuMQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=prIOze5WHLtz4R6rv7XekbdCHdUuylsdVG2jV4VcE/KQqyF4ie1ymrfjqmqi8DZit8M8a5o7v3Qh5suij0NOMlyxSvbbvQgJXgJGYl+isEluC5wX4EkBj2ylrneVOfFCgnv+cgBTuVyY7G6C4HQv8o344pnNZZgPVfxc1/m7nXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsZ8bh4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsZ8bh4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F0E1F00A3C;
	Thu, 21 May 2026 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377025;
	bh=T1b9EYepw3rqJofblBzYVSOXtnRf3uYEx2YByOdaANI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LsZ8bh4Fnl6LeQZ88ewSQlHaanueZZobfS1jxmra+VH0rDvBNVEJSDQPuwkwpgo3Q
	 avwsZC1WyzFerI+WJgpcKK3yOn5YjRSj7kKIiTq82qF0YJqnuD8OYIQdUQuqjr0Pnp
	 A4WKjfPrem0I6UEQ1J2I2EcUyr5CMLgRNRzdSjdoR3aJfwIK1Yh+l6ZrICCX+L05iL
	 P5oi7lwcnniOG1PA2qhF6j6dcM/uu0FdIC5r/X2XwG5cDB7kYFCd6vSO8lHbrcpuLl
	 RswWq2I9+5E+XZl6KkEHePArDoGOg8AhAODEqzqRX5x/Uj3ey3+hmWpC5SAVj+nFso
	 9ECbQmBxDTwcw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Jiri Kosina <jikos@kernel.org>, 
 Louis Clinckx <clinckx.louis@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1778701376.git.clinckx.louis@gmail.com>
References: <cover.1778701376.git.clinckx.louis@gmail.com>
Subject: Re: [PATCH v2 0/2] HID: lenovo-go: clean up USB assumption
Message-Id: <177937702428.1117151.4555885797381276813.b4-ty@b4>
Date: Thu, 21 May 2026 17:23:44 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 15 May 2026 14:57:38 +0000, Louis Clinckx wrote:
> These drivers' id_tables only match HID_USB_DEVICE() entries and the
> code freely assumes a USB transport (to_usb_interface() on hdev->dev.parent,
> endpoint access in raw_event). Make the assumption explicit at probe and
> drop a NULL check that the compiler-level definition of to_usb_interface()
> makes unreachable.
> 
> No functional change for the supported (USB) devices.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.1/upstream-fixes), thanks!

[1/2] HID: lenovo-go: reject non-USB transports in probe
      https://git.kernel.org/hid/hid/c/2ee7e632405b
[2/2] HID: lenovo-go: drop dead NULL check on to_usb_interface()
      https://git.kernel.org/hid/hid/c/da7f96a68c39

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


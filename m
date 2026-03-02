Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06825367F3A
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483576; cv=pass; b=VmwDIYUk9+avnqtE5al7YRdBMkoivqnPuRyBaSR3kUPB26GuruQb5roO2BGpmRMpDDnlR95EQblxirdpaJiqgL1DyFE4B8Y5DkP5RgasVwPhGkOnfNz9N/G0KuTWOWi/bfcXp+E2X8l+fCaxIlQ4OVHcZnMI/3QhYRZf8AWg0Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483576; c=relaxed/simple;
	bh=flcTd+wNy1G9C+3yGzQ3mHVcbX3iyvCsBn5OyIFxpi8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VKDru+IH7ozfkckjfcPcVp3FeMAeru6SuW0a0FxxEsPMp4iHJj4mApynfGlBf6LnxZeM2BgqKwmtfvRq/HC1xyzWZTdyM6M1mOEDEOUD96MfkBiIIn6lJCHDUNgkyR5CKrEGtAeG5n7yuO4MxBqm+fcHYHEWSZrqnyh5YBGskvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyTAPz43; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyTAPz43"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7982c3b7dfcso47265447b3.0
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 12:32:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772483574; cv=none;
        d=google.com; s=arc-20240605;
        b=aINm6l7h8ApcXfyhdxhlipiGjDia2t7dOoEGcoLcTSq80OeIW4h8iOsb7qZ5B0V+Ts
         5ZS04tX4vO9TGrJZWmeP8Yf0RIzZzo9BkyxtyCM+h0X7/9uPl1CMTp7Anb6tT7b/MpIt
         OK8eJSMPDU0cFHg34i+gsBKhcPK/rcu0kKu2/jinhWSUqNYZeuJnN4gjW95yfcvTfg2H
         TzhHNSY8W+748Sq8fN5M9Anphwogbg/OO3HkhtJRUUTXfU+b2dSbrLUqVjC+9JJhNY+/
         8CxXsqoQ7nqbS/FwyiikEO0XojoLOV92pC9ol94YcpmE+jZ8CsHnBRq/NZYkmlSEozlE
         uJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=em57ZkRxC5BlLOvFWyG+lwKc/F9rE7HyN9LCvsMCgus=;
        fh=enjSiehNwoV+PkcvWBttonxpTM2Yn2N6bUSaMdmePSs=;
        b=FdYgZgLlbYsLhFb5ZTTA8CVV3bcKY8j1pEKMbhRFqzhGKQmB/fKcgm4RYjF/k3Y26c
         ClZcQIn9uRj8ynewmPYDdFnR1ncIOEuatJg1VfPvVI9k5z2gpEEHU4t5+i7lw05FFv4X
         YP41azovM2sa2dremN3ikffxlz0Kz056xYCdHrDosJTRBvSHyxrbS+cZwmmtb2fz6r8N
         8Bc31HYBArlEaUfrZcLr+vdaRFr9vCEl1NT9a7FkK+HqE9QmrQxLtGkLzkgfc/Yczwqz
         W1d0A47S/9TSfjgAL8JdYniZAIrtWap0JR9KiAT1wn+vw/D2k62WyosEWwrcjxSBA1+h
         ycVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772483574; x=1773088374; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=em57ZkRxC5BlLOvFWyG+lwKc/F9rE7HyN9LCvsMCgus=;
        b=WyTAPz43E3DuH9BZRyEzQHm2SCchopGyCNMYhz3YfJSWv+CVEgIMoUbV6TAjBWfB2A
         XG/51KZaz0aG8WVbLobAQg40c0sWkfrSSyJ12Y5F2W00XG6/gusZ//VEHymTgyYw0kQh
         I1esPwu3RvPNxzZTKq7Y3prqwJTf3vy5SUsG5EO2/dEjpYpn5BXXjgzid8ByZWnKCSDc
         H+BuCBMbZ7c6aq1L5i/OiL8WfgMHVJeOIqY6TRMHeNB1I8FGQ01RLe++JBxHyHlPEcgZ
         IlN52Jx/V7iZJHlCRvsv1S2yut1FbGXssq+gSMvHEOEeT5UkU9Mn/4eamdLdvpPu377G
         lIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772483574; x=1773088374;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=em57ZkRxC5BlLOvFWyG+lwKc/F9rE7HyN9LCvsMCgus=;
        b=CB1KDRaSsnb00b/Px3qqHn+mjuHOT0KpctukbfQG9eH1e64btwiyuFZBm1wNTflRUa
         xLcTGGlm5BRe41xLDINLn5yPic3ZgfD+xG6Rv+38GzD2RIUqwbbW04thWdE7fT0ago/j
         saO9L5lPN8NavwCxir6yt2FaK2YMy+V10sWo+FeZXl2o42PF7PBIYbqNBo5zycXw8dG2
         Aj64hvMfoPy0wXE9E2ro5S5tcSQfwdH6FVyuNazyWDAjOjyYt7i+6uiR/N1lbjFG6SbM
         galCpBgpt67Jbji+tXL7h1blP1aBmmf6+i0FAdKrlSdaFtcTbR5ID85AUt0RvRvmH0DI
         ktGA==
X-Forwarded-Encrypted: i=1; AJvYcCWa43TZ172sS9PJa5EvryRxkDPrsEplD/xjATa/UeXUFxE5RP1u2KW7hueKYB2xB0gIv3G41NKhUW+uNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXN1+oRBsbzhhfZsBHihvKY2FMbjcIiConCMpU3sCTbAV487C3
	MIjZTBHwzoYrMB6xN3hdvc/mD06cYsdj4MXSL7RFVJDxjhDkKDOaGMaKk/8Kb+K4ec+f/rj+lur
	Zpi2yCELIBIM+Xz/c2At87fqW1peqNaB1vcOjuaQ=
X-Gm-Gg: ATEYQzxS3FVr9asEdct+eg5YDe2/NfxqjfonCJvl8FOyYF73/4cVyGjCD4igpT+Iej2
	t8RbkrN1xc0OvDMkomMO023bxEjzbKGi5kgjv+y1uYXgGRtvAqOL4LezOsrMc8GCD85OYyWFG6b
	q+Ll14aYN8QGnSWTSkwSL0EbFOfQ1lnL3s8O+A1XdHTwO4cfX76wqCkFmCIszFN3P9pamdoihE5
	UEE1BwIkTzzSc/sCuynhl+WDQK8COU4jxQ+jOgF/jS8oFce6KZLpc/pfe72NXXL5S9AHMHyQFdZ
	71UXd3XbSBlLvnRPhdwR8bVxNGTYoAxL9T2wR0fy
X-Received: by 2002:a05:690c:3587:b0:796:4004:d1d5 with SMTP id
 00721157ae682-79885609102mr119790877b3.59.1772483573894; Mon, 02 Mar 2026
 12:32:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ngon <ngon36201@gmail.com>
Date: Tue, 3 Mar 2026 03:32:42 +0700
X-Gm-Features: AaiRm52frTHqnYyhNAaTErHIwCx1Akl9QCzkNVb20yqccqSwHanN95Zegm7avCo
Message-ID: <CAF2ktaUNWWED4g+wqa0OuFbXSaVV7Lt-9Kw3co9KE+PYswNW=A@mail.gmail.com>
Subject: [BUG] HP Pavilion x360: Built-in Keyboard and Touchpad disabled
 permanently after screen removal (Stuck in Tablet Mode)
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry and Linux-Input developers,

  I am reporting a hardware state issue on the HP Pavilion x360
Convertible 14-cd0xxx that causes the built-in keyboard and
  touchpad to become completely non-functional under Linux.


  The Situation:
  I have physically removed the original laptop screen (using the
device as a headless mini-PC). Because the lid/hall sensors and
  rotation sensors are located in the screen assembly, the Embedded
Controller (EC) or BIOS seems to default to a permanent
  "Tablet Mode" or "Lid Closed" state.


  Observations:
   1. Running libinput debug-events clearly shows:
     event20 SWITCH_TOGGLE switch tablet-mode state 1
   2. The keyboard (AT Raw Set 2) and touchpad (SynPS/2 Synaptics) are
detected by the kernel but do not emit any events
      (verified via libinput debug-events).
   3. On Windows, the keyboard still works despite driver warnings,
likely due to a proprietary HP override.
   4. On Linux, common kernel parameters like i8042.nopnp,
i8042.dumbkbd, or button.lid_init_state=open do not restore
      functionality. Blacklisting intel_vbtn and hp_wmi also does not
force the system back to "Laptop Mode."


  Question:
  Is there a way to implement a kernel quirk to force-ignore the
Tablet Mode switch for this specific model, or a way to bypass
  the EC's hard-lock on the i8042 bus when sensors are missing?

  I am available to test any patches or provide further DSDT/log details.

  Best regards,
  kemzsitink

Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75D31E824
	for <linux-input@vger.kernel.org>; Sat,  3 Oct 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791016654; cv=none; b=Kj3OQrGT6OpDWQtPsGU88Dh97GvsEaaXd8Ve0NKRQu9n2KLV9ej8tOKlnBKwBgf62rN82MLWLMCMge0IaJPHc+ZfNr+eaDL2/sAqQCFx0mxenqSOer0Li/iq//nAAIhChZb83MCFd5UsFqVFExMTZ74vuLrGHIIfQcEtpIeuAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791016654; c=relaxed/simple;
	bh=aBWvTsNPzbQFDIL4FkRHijKvYYO0x4LXeBXvfhyEpp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oX/Szc2PZZvM9yDFIPVNip6pSF9UopgmsSmwG9o3HXZHNFGaPk0pPEEB18Z8y6cBNrE3QylkQ4xg6zVdfp1Vc3wkxb1hFIQduDiIpckR2Jtiw5bp4GW3a+8TUa+ckxmtOveGus0b6ZXB64PStsn2VugBN1J17wLnX69jsyBArLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj5t/2Pn; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj5t/2Pn"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b3e517e6dso102292eec.1
        for <linux-input@vger.kernel.org>; Sat, 03 Oct 2026 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791016653; x=1791621453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBWvTsNPzbQFDIL4FkRHijKvYYO0x4LXeBXvfhyEpp0=;
        b=lj5t/2PnfwHE6DmB2EFDXAuMby/+Erhv0pgv0SjXejKycyDqOwN03VZRLFm0NgGlfC
         vjDO4GR90ZDBtB6oR8e7siOmYIDmh87EJ7m8mF3TCEkYZMHGNOdxTXteXziCQeaeMQqJ
         IeboMxdPSgHNc1u7jK5/yFM9kyLoHRfZ/jYVN95oQlHBXdwSNt6AsEOqJ++h7QrqQrjr
         hX7fYA86ZBnD0wPevSwBhagZyHXHFXhsNKbfbaOH6ptEdWHJRel8395XHajXg/kQnzve
         /ERr+4z5Zmj7un5ndpQbbel40S1b25wNFao++uf1a9DjOAE3AkW3fJX7ch9HSmBJMfZp
         tgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791016653; x=1791621453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aBWvTsNPzbQFDIL4FkRHijKvYYO0x4LXeBXvfhyEpp0=;
        b=LW/e9FaQJtYcafNJz2e/HXqmNJySW04q3pwVeIA2i5YpsbB5kuoracSZa8fd0O3/Mz
         t+wMhmzuzXVrppm5Cb59sg6/lC4fmjWlVC1ar5/F4ABq630dk3bh0UycVJEwgqOOTuci
         Jl4K9CELZymIHFVDXjFTcai+1yXvpdghhkQmm9fLkkgmdtpf0K7OWq8Uw6E83QCvZFre
         1z7nxNO84suS0uGHSFlMRFwat5zUmwab9K7+dxVG8aeT68NmmP2NJ7UsEUFtY4XnWsja
         bxEUBpGOL1ulcKTypC+pP/gIPBuKBTXJTHUg+nk2hr/RIsdWnVYGhlRvxmcrWPshjBlb
         wAJg==
X-Gm-Message-State: AFq9FYLAjDoxbxGIBnkb3pjAyXVCeJmji5SDaAe26xUJvMkqW7WghNXr
	vP2zgSXKWk7kUUIQyxmXW7PAqdIeRhHSoDW9D0UBekpLpdnCHDh3dGW8Rp90Uw==
X-Gm-Gg: AYBFou0+u0jXGRy65bfkzxzZMThyFNh9Din/E8vmaI3LZQQGFqlhGPvzmXuPmK5pkCO
	27ZeoI42AZknoMm0ErxS36UYesM2e1LdCjnQ0z9kLkj7fqRbe4eZNsVrGVDtAk6UWpMoomtEo+y
	Na6yqkutkrc2EWA3Rpn+f96a6N4AP+XWbn8MBRXApHe/gEAZUbyk5b+JDVd/Ig3+hx8Juc1EE/1
	T1WZdIJTYtGiS7dgx3XE0MJCJqlcgQFMOfWe8o4HAbi5Hg0T0gHXtImQ6xzkt/4s6cLdSFB3X/l
	BuT5DZaRRd9lZFDgWSpy6STOnJ+g098jrBiP4ETAjhZi0hgi3U04cTEh0Odhpiue8XOw4bMiW3H
	0uH7sqbRGJzOua4y0ZNtIqVRPupatHe8tkU73syXQKCQaDDnEkQZRLG5k6eQqj8j4TCVe87tjP+
	VpmZ26o3HC7k5tbND/VzZ534eYsJrGtW53WSGfghCj8l2tAYi58VwvvN2pTbofjO8ZHhfldVN4N
	Nq7oYelk+RmEca9Vg==
X-Received: by 2002:a05:693c:20c5:20b0:33e:3f5b:3ff6 with SMTP id 5a478bee46e88-34f150ae2cemr5768703eec.18.1791016652715;
        Sat, 03 Oct 2026 01:37:32 -0700 (PDT)
Received: from arsenalgear ([2601:647:4000:ffd0::af37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd5620sm13223266eec.21.2026.10.03.01.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 01:37:32 -0700 (PDT)
From: Uddhav Swami <uddhavswami@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH v4] HID: chuyuen: add driver for vendor-specific brightness keys
Date: Sat,  3 Oct 2026 01:37:31 -0700
Message-ID: <20261003083731.104889-1-uddhavswami@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817073319.33200-1-uddhavswami@gmail.com>
References: <20260817073319.33200-1-uddhavswami@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiri, Benjamin,

Gentle ping on this patch. v4 renames the driver to hid-chuyuen as
Jiri suggested.

Thanks,
Uddhav

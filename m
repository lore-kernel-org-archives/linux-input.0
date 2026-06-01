Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3554A3E834D;
	Mon,  1 Jun 2026 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338016; cv=none; b=g2Ri/Jaiu5ftdJfvrqygfsu4hj7W/CTG61W3j3vTx0t/0b9nwghKS8LSBjjrY8ByGrEzZTwVXGnnEP2VmzfSzxrfjzxufEOqzLOFKdaQ3bqN/3CDTmZNvX9f9WOaoUSo33ZkUcPn70lw3DNBjdbD25Zyt+IukjWgWhjsp+rMWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338016; c=relaxed/simple;
	bh=pIVbZUjSJHZoB8iTWLx8QN3/wuEzFkuc5Z5kJd/k0f4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oCgLUJDuvl0tBSQ4NzAJol3i4OW38i12o4+5nRNPPMpkoPu6VvSRjB8U3124+J7EtClclevSwLhgFW8rClJ7a1LfYD91LmUWAjTKX2FtPEde/kUSf/vBT5dZwxMTaZzlcMM0Qt7ZXnRS2om5pzuZxrFe7CLUJh1LwiEm3avfDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0Ik5JRC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0Ik5JRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F6E1F00893;
	Mon,  1 Jun 2026 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780338013;
	bh=Nvm7dgBjhL4p9XphgkrhOS6H8TXlFsklmpQ+mK9xL/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=G0Ik5JRC9SABh+o0K27uZyB3SRwsVVCS8APyo2gxZBSweIB1MRh7oGzev1EpQdQmf
	 TTH5pg4NEaTa9iAjaLv16cFsmw7TpMb7i287m4WnlVpJMkeNhuPUO0GG5VkkYYRMcr
	 6urtVO7U9jpBXNXdxDAjbGT6vFIHRb812qX6vOOFFO6niFA2Wykegkd15VNGCDnKqJ
	 UKp+nDrg/1B5MN+H6OIWjv5jhoIXeu/jPUv6uF84KKG/vf7w46Ghgdoj3H8uYJ72J1
	 y2bDddIrxtHHZ8IOmY8LIPqx6qcQMI5QZLOFztUDY0NZwd27hqogWvZC4mMbKYV9uc
	 BmBHSGn4hLt8g==
From: Benjamin Tissoires <bentiss@kernel.org>
To: linux-input@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>, 
 Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20260531000150.378695-1-rosenp@gmail.com>
References: <20260531000150.378695-1-rosenp@gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: remove excess kernel-doc member
 in hidpp_scroll_counter
Message-Id: <178033801201.14733.15822909876784616809.b4-ty@b4>
Date: Mon, 01 Jun 2026 20:20:12 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sat, 30 May 2026 17:01:50 -0700, Rosen Penev wrote:
> The @dev member described in the kernel-doc does not exist in the
> struct. Remove the stale entry.
> 
> Fixes: 0610430e3dea ("HID: logitech-hidpp: add input_device ptr to struct
> hidpp_device")
> Assisted-by: opencode:big-pickle
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.2/logitech), thanks!

[1/1] HID: logitech-hidpp: remove excess kernel-doc member in hidpp_scroll_counter
      https://git.kernel.org/hid/hid/c/f22a5db8a7d3

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


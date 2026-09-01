Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E86353A9C;
	Tue,  1 Sep 2026 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272530; cv=none; b=oGyXJlMVMIU+EhPXM6JbjB/XjXG+1CZLwPVg/fwsmeBhqesL9DMc06wKicH7V52Hp31uJI1BjQy8HVZ3Wc2cXkUDIg1ouIHAFCuNcK+QpvoJe47XEoqlEsJxFLXBc5lsyl/jywIdZLF23U19DIrfkcwiYF+rKHcAXcP/sGfSpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272530; c=relaxed/simple;
	bh=z4MadT9EoyNUCgnUtZ6bmgnDwqZvLn6RGtScngXlUuw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IAFoFKh06vNEZ314/6qVAvpodsZpRploIXQ5/GjDEzMNE8hRXJrfrJgQ8a+mx1+Z7TU7zI+/Mu885mhhSlz+DHCJU+u6NWoUEIau1D6CWCRHZ7yNemgE1KUhbOUvDhsZ32Qe/2AkOTphWE+UeQ3PCWOsxG447DwPMUNY7d2IGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvjEjEiX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvjEjEiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76A51F000E9;
	Tue,  1 Sep 2026 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272529;
	bh=NnyxHu7cqFkAFYRLTeOp6uPCfbYgMeEnwGOW6JOclYY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WvjEjEiX54LrCBWgObLi09hmA8O4U8wjM+Hzq6lPC70+o9tQBvi250dP5nX7NcY/s
	 KNvbeKrPoecdlhV3UKgh4S0ZiI686Qt3VuzozYiMK/PkJHCa2BXR5MxqJxUeVLCBiW
	 +N8Ec104vwEe+9j8IRmSa3I/IpTpf/afmMYhmh0KGnQAnB5rzZzuNkaPABz1+BxgDV
	 blqlKpyzRCwzgxN+WfWqoL5+CZWfG27jQj8S0h5x81/F47ELdWjFnxskCiHzqNlzh+
	 zYesDiJV80v0K9fZEN7+k1L7Vo7IajdLp8Aycw7nIhMPDRlq0zMiWeGV66HDVQVZ/L
	 +M17hROOiiF8Q==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <20260825-wip-bpf-safe-v2-0-d044355c09d8@kernel.org>
References: <20260825-wip-bpf-safe-v2-0-d044355c09d8@kernel.org>
Subject: Re: [PATCH v2 0/3] HID: bpf: fix 7.3-rc0 bpf breakage
Message-Id: <178827252760.3572676.12982586415441930944.b4-ty@b4>
Date: Tue, 01 Sep 2026 16:22:07 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Tue, 25 Aug 2026 11:55:10 +0200, Benjamin Tissoires wrote:
> With the introduction of commit ee9ad135b208 ("bpf: Reject a store
> through a fault prone pointer"), a HID-BPF program which would try to
> change the name, phys or uniq of a HID device would be rejected by the
> verifier. Also, this commits and its siblings manage to detect the
> buffer overflow that is currently dynamically detected in the test
> suite. The verifier now rejects the bpf program we try to load, marking
> the test as fail. This is correct behavior, and better admittedly so fix
> this so the CI stays green.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.3/upstream-fixes), thanks!

[1/3] HID: bpf: mark struct hid_device as safe BPF pointer
      https://git.kernel.org/hid/hid/c/67bfe48a29fb
[2/3] selftests/hid: Add a test to ensure we can write fields in hid_device
      https://git.kernel.org/hid/hid/c/1fb68c2e7638
[3/3] selftests/hid: prepare test_rdesc_fixup_get_data_overflow for the new verifier
      https://git.kernel.org/hid/hid/c/ce58f5a18432

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426101;
	b=NKvnwH2Yfb9xhxZvwKex8Ocu9h6GcKijgjLgXenVs2fCBE90HsnAtcyk2w/ZY0I8C0BF
	 Es7BeezOJ1J26ezfUj8G+s3pBJAaLUn8/j2DkFOtTVKmkiU8VMuJ0Yf7g8I9cCmfNdxgu
	 WloLJbvQI+EKjm/gkL8yOerMLtVKhb4r2XWmuhSNKmRyPoeM8bsjHIlsjZUlBL9aj8Bep
	 dE5K10AxEhR/DqUpsdi8r6xNzuw5FdY8LxnA4EDGbpC2CGy6k6ifVl2dfQKoeI/f9PpW7
	 BdnsxQhomtSZit92COQN7gJbyr9UItxXLBSRkx1po9N0I/YdwukXJdvRQziHPDhtD1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xMh8nLDv9y7NsT+ecpEuvl1iTz2rhgn90sr5gGapFe4=;
	b=KBDBUSCdqO7BFHcf2o+NoTDtw04AKRUGvWKct8ff6TlHmAwryqCt9Qt282wuLBgI3uUC
	 AIQr5hmvHhkzM94xknUN9gjWSXIfjiijaFRXpRluwftd4zURAa4vUcYMZv5B7iBJc1AeV
	 iJhG4Y9vIlzxx8JDShO77kA3LzyDlEgjLrdxnHDXLbrN1+1SNBRuemcD6DKv63O8KYTA+
	 GToEezioasnRRlhGeIXbQaetV1QQj6Hm6dQaBgqVfL4VZsG/XlTwGUtLgoo6iNrvl4ftk
	 cj/mrF+w1czH6RFVOm4GNYOGPiTYR2Teb1dUkZOqzakARH27vH7E1ouy/FEFW07TUNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EIGlLh/Q";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD4F606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 09:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBD4F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EIGlLh/Q
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38564b4b017so3297557eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 01:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795426100; x=1796030900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xMh8nLDv9y7NsT+ecpEuvl1iTz2rhgn90sr5gGapFe4=;
        b=EIGlLh/Qjr29R3wYSOqe6uXfmo3k6/RWKWo2+0DbA76xCFksTWx1pJ+v/6bKzq0qK5
         647EAPnyjElcZqWDM2MeaY5xI0FEuYdtcTwNcCAURNaiKd9jJ3Lhc9g9Sua6Gz0uEV5d
         ZX6csy5DqvefAbdQdr0UQJx2tQIgSt2LylMsrpPecD0kzkvK0doqqMBwU4AG0t/89rSG
         oT/NHE55yKtWNbOl5Z482vFhW8613MzvUNeMfAmJHPGwPhOuYmzrJYXWQjvvNSZLrx5X
         +Mfbb+xYokZBP00QZiSlMyww34WIeNUYdh+2h/wx7c5Qmt5zMplQjIr6ELcHy54n59p2
         whog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426100; x=1796030900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xMh8nLDv9y7NsT+ecpEuvl1iTz2rhgn90sr5gGapFe4=;
        b=Irv5rG5kDiPFKskIdbMIFqdcINR+T2QdqUYEBf0PzO+tff8X2lDkZD85B8zyaevzax
         6KGZEsJS+RqcWw9htxIH1Dj5T2Wtuyxmup8OMvDkP423+Zrh5n+kocpdq/qChPNrxuxy
         K9nKLmQM0KFNduf8vxoEODP0oI7vyOQZxk1E153oV/jujDG7Wi/plYxu72hj71AVkxx4
         rgXDhEpAFTlop/u6GprGW9YqRpJUjA927FTE7AfjwkhxjiqgPIr9vY4HM+GhjlS5lG4C
         +IUpZBFirspDGSRZ8keosDgmfCTqAdB8FEWlNb8sdxgsKtfoqHD+oy4IkhWGYpXQWzP+
         sjKg==
X-Forwarded-Encrypted: i=1; AL+hErEMFvUxUc29cHbxqhYFVx/VrEtsXoSZ6P4Z0hAjR6awj191t5grnGxpLz5OGtpB5jWfilX9ZOGO2bNcxA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+z9fOBBei3MFfYVYvJM5uZdREwLTLvt2t2pA2Q5sfUxCW1Arh
	/GgwsQVJ+7dgmEqAMfuvaCkadtpDlMGccaeNEhad5VTV01PAWUq4liK/
X-Gm-Gg: AZFdTZfo7hVjngAX0rCuKVokxgoh58Nzd+ZBZrB60AEf30rJgYWcaD2W81hMir9sIqO
	M8UKlKfR6wEIMBr/PNHMrn8PFnEdXB8s+vjDZsomg3xvOhPC3QsvUhceUqARXrf338+wKEw1TYi
	pNw61/stgtdGj5vmnTSfgftc8gh0kmdbzplZhbRBkqRJ3NMvEuNYYOFOltAdo4Vmi7eA3b9eSkG
	7dLp4n2JD8b1srvs9xC9SOAL+RKH3unlyb8stkoHWsxr620yJD/a1qBI06lxF86v3ujaqSkczYX
	mx6iX63uEJWcPZTj5czPpIQ40+8kcTGr+CeOcxUs40nJ+BRgPG4pQyV1LGNMnB9VUjxrPzFjKe5
	g0w8ufc18wctZ7kuB7fXVJFcRYRW2MZApxCIGNEOXRwn+5rC3BO5sTqvw/PW5uvrnDBQr5W35zn
	70zIahMdTh61pMG0JFNfHRYdBfQlr/+R3SwhW9DWzgZ11IWIONKDxL5mE58fDWQqxVwaJbXniI4
	ic3Z3fPThF8thC5zHVkjBQpNpHwleCBxHX28NyB0Hqh+Tz721SfcMuwT512wh/wXnr6mUtTOyyt
	kx2zQVfjsO5tgGNnadpkD+fsLn0Axjv1q89B6WoSUVXw4FiQ9wwbQ9HU+fji3i5a9ixLOQS6OFw
	=
X-Received: by 2002:a05:7022:4181:b0:14a:a6dc:9cbf with SMTP id a92af1059eb24-1b5568abf0bmr16302203c88.4.1795426099783;
        Mon, 23 Nov 2026 01:28:19 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm19861941c88.11.2026.11.23.01.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:28:19 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] HID: intel-ish-hid: Reallocate buffers for a later, larger response
Date: Mon, 23 Nov 2026 17:28:14 +0800
Message-Id: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

process_recv() sizes the descriptor buffers of each device and the
hid_devices array by the first firmware response. It then reuses them
for later, larger responses. Patch 1 fixes the descriptor buffers and
patch 2 fixes hid_devices.

A pending patch [1] limits hid_dev_count to MAX_HID_DEVICES, and it is
still needed with this series. Patch 2 touches the lines next to that
patch. If that patch goes in first, I can rebase patch 2 on it.

The series is based on hid.git for-7.4/upstream-fixes. In mainline,
patch 2 conflicts with the treewide devm_kmalloc_obj() conversion
(4dd10fbbeb9c), and taking the lines of patch 2 resolves it. I can send
a version for mainline if you prefer.

I used an LLM to help write the harness and these patches.

[1] https://lore.kernel.org/all/tencent_130404E5ABECE66E8D0E70D8E6892C751C0A@qq.com/

Maoyi Xie (2):
  HID: intel-ish-hid: Reallocate the descriptor buffers for a longer
    response
  HID: intel-ish-hid: Reallocate hid_devices for a larger device count

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 41 +++++++++++---------
 1 file changed, 23 insertions(+), 18 deletions(-)


base-commit: 10bc1d627c297097cfdc099377f8a13efdfffd86
-- 
2.34.1


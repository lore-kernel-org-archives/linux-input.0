Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA546EF96;
	Fri,  4 Sep 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526393; cv=none; b=rPYO67ZqoJvLfEsORHYbH8Prqg3POoeP0BYSaeGWJyym/Ub8pi2ZhvOGFfRLfsMDmy8X1JRMCLMcmFwKKkJpeMzlesxnOLgbQSf3RB4f3IcI1EZ8BMcUATZiZ7eYrx8cuTAvI3CU4qHyoztlld2qDUkrGZ2FF7+v/LxNT2H/Hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526393; c=relaxed/simple;
	bh=EXP+9uhKnv18gdtS0auCz5rHoNCCrXIV9ZB7lyMfSTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KyavguwmtetuAuPYLSZZgSMK/4eXFxpyGFYJJLygAEahOPcsNqvc9Jl5AnpCLzc6iDHSwysoFokb1cIHaSkIRyZGuo7YDliEpiPOYZokxzWIqsxQqWcSmYbA7H0EN/1+ZkVkMSPeuhGrQV7ScDumEonVpU+0TLJi7CKM18SQZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwItbSWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwItbSWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA1A1F00A3D;
	Fri,  4 Sep 2026 12:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788526391;
	bh=5lMsDoA7ayIFRN0SPd2Tg9PHAfNDpGqM1j2GBYdV9dc=;
	h=From:Subject:Date:To:Cc;
	b=MwItbSWkanP+z7n9mRD+y6jy8AdU79J7E9eFUZb2GZtUwO7qPTmZoHwPoM0mACGj6
	 ccYso4EMv6UX84zHaIce1dMLd+vkrdxOFgiz7hzjPXsyywcIs1G7NqJnremgxNpR19
	 rRz3yX7YCuw4HdgzcKWrzFtty/DQH5mc92ubVGMWajC1QmRz9plq2dKdHQUG3dCNWY
	 br2oExGhXOnm/WotsxecILG6Ns7F1JM75riH65cANAWYvLnU1GHQ+IX4B1e9xi/ZIM
	 FVIMZ152LgjjxjGM/4Ft+OpJ6l0VWoPmuf6jt/ZcIbh+KxinNNh8Kak9If2zN2jClV
	 kv/o8xoG3wzhA==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/3] HID: bpf: fix __hid_bpf_hw_check_params report length
 computation
Date: Fri, 04 Sep 2026 14:52:58 +0200
Message-Id: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMWwqDMBBG4a3IPHcgSgjarYiUJv6p04KGib2Au
 Pem9fF7OGejDBVkOlcbKV6SZZkL6lNFYbrON7CMxdSYxpnOWH5LYp8ihwnhcVGkRVeOtjMjaud
 bZ6mkSRHl89/2w+H89HeE9feiff8Cj5CORHgAAAA=
X-Change-ID: 20260904-wip-bpf-check_report-f490de16b864
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788526390; l=1263;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=EXP+9uhKnv18gdtS0auCz5rHoNCCrXIV9ZB7lyMfSTs=;
 b=QEdk6DrzJp9gZT9NZRa0S1ssk/FMprsMletgwJrbuW62OHNegQEdhG3ATArpQIeeSjfTLXlyf
 CfwvT/y+H30Ce+RYWxzGMx5KECyS6N5uLYvljmO27Nr/nFcJZi3F1Ez
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

While playing with hid_bpf_hw_output_report() on a device without report
IDs, I realized I wasn't able to send proper reports to the USB
endpoint.

This is because the __hid_bpf_hw_check_params() check wasn't taking into
account the report ID reserved space, and it was trimming down one
element in the report.

Of course, things are not simple, because sending an input report is not
taking this extra space into account, so we need to account for the type
of request as well.

Cheers,
Benjamin

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (3):
      selftests/hid: add define for commonly used buf size
      HID: bpf: fix __hid_bpf_hw_check_params report length
      selftests/hid: add unnumbered variant to the hid_bpf tests

 drivers/hid/bpf/hid_bpf_dispatch.c       | 12 +++--
 tools/testing/selftests/hid/hid_bpf.c    | 91 ++++++++++++++++++++++----------
 tools/testing/selftests/hid/hid_common.h | 25 ++++++++-
 tools/testing/selftests/hid/progs/hid.c  |  2 +-
 4 files changed, 96 insertions(+), 34 deletions(-)
---
base-commit: a93f3bf4e1d60777b1659b812c9e818cfc53b449
change-id: 20260904-wip-bpf-check_report-f490de16b864

Best regards,
--  
Benjamin Tissoires <bentiss@kernel.org>


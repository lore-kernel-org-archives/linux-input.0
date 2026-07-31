Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176542C513;
	Fri, 31 Jul 2026 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521624; cv=none; b=qxushmC50Rg84Y5vKlNvYIN9BzPTfRiI/WM+UuS9/XwPfzS7TsBkuVYYM3MfKXGb2qyKjBst9oCkjtVVH4rOG7FtW3T0uOunvTkkbUo0uC5B9cn7TCItug/7epvxlF4wV4RPv7YFQw+uewUaIp3tDfGnMoQeR2pETzqpbxRdJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521624; c=relaxed/simple;
	bh=QH6rhX6GTBqhnnmniQGR0A1Bs7zSWu/v95M/i6cELvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QKBko3omm/TS6yDo47wYi5qER6+S8sPl2INEWE1RfJlOG2onUeSWHuehEs+7aVftFzjM7ujyv5mOcVOfU+BZmeELhF+hQNpY24ixcAFpCkXcQg5dH9tqS9w2Yp3bMq3nqt0QNx9XboUk9yRrsZiDss4TelO6qBBhlaQIV/UhHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkfP7X2l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkfP7X2l"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BD9AC2BCB9;
	Fri, 31 Jul 2026 18:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785521623;
	bh=QH6rhX6GTBqhnnmniQGR0A1Bs7zSWu/v95M/i6cELvw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=CkfP7X2l+eBmCpGt/2tFrvEjePo6KYT04QE3cf6hcMHKTxwUohEyh5NsRW8a674vK
	 ssMZRKc5/uGTQ7gCa5qH40KSvTnG+TO98XBsudoPe4fqZ4hbXQBTW0NeKTvlpteWIB
	 +9eA6NnXJxnLkFx76hQQE4yhS7Q/f/v6U95qJ+/Y+IU4svbu+/9wBfmDTBcEjgl5nH
	 LANq/cg1IhicjptxPukE2evlNE7Le9g2guMPVqzzuA0fJ39LEiOmeTM57zo86TrFzc
	 ARtO1lbSexOdVL25UIRcPrPokMem4LMa0rVDKS4XmG3FHVmI7d4WYX94ql1eJlK+hK
	 EeLO9mMuUPKGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58846C55173;
	Fri, 31 Jul 2026 18:13:43 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH 0/2] Input: rmi4 - honor touchscreen-{x,y}-mm
Date: Fri, 31 Jul 2026 20:13:40 +0200
Message-Id: <20260731-respect-x-y-mm-v1-0-3e85a4bec745@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrE1SJRquIhbFYCR+0kGIuLti+
 S3eu0DIMQnkwQWOdhaeJ48oDKDu7dQRcuMNWulUmThCR7JQveKBJ44jtiaxOjOKssqAjxZHLR/
 fsCh/y1YNvngvcN8PBHKtSXIAAAA=
X-Change-ID: 20260731-respect-x-y-mm-f74a2970e9b7
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=QH6rhX6GTBqhnnmniQGR0A1Bs7zSWu/v95M/i6cELvw=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqbOXVtsLTJnFvCQFOknc7zX2vdae+YTc4iKEby
 WZq6CGfNRqJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCamzl1QAKCRBgAj/E00kg
 csQED/0VgFmR2xTHUCDCPDe0mqBolsFDp5+W3ZPjiLKCeB7idnjlaZKLrUAq4F+waWqIDcZ5eyY
 u93uB39YgvDaCldllltCrwH7iK8W9HRXVeriJNTrhXu/EyGQ2GddGlS53bU+bs212GeztldG5/Z
 PV+x+ZVSUqh147cEtxcA/txBFEvsIeitrcv2PbBr5TxJDG5Mo9kgCqVCvmKVKxvM9QwPweK9XLc
 Nbg6ozRAHpiFJD4oDyrJeP7F3q8WXTt83zH6MbRH9DO1kbfTo+Utymaba3M11tAbXr8taywSIIL
 UMpEy/VG4fAXlAr27NZewJM1DxlFI7bYEUH63mjEQwQlFDbE9n/4zPk8itwkfWuUHf2XD/mFRxG
 eYRGTsn3lPChXifriWfooIa1rWshz7QajVv180HhjCYpcIcc45qAfVuVwLoHJcDUASVTxNSk3cw
 qIAXpEhr5EPysriXp+SO9ufPjc9HISQZkaHAwecrzpcM89lUFhDIjd1TU3end5xfSWnC7TeFDBw
 HAgnPrvN0spACKDzzlPUdlfEMqwKIejDgEcQukbL5faMZFF4nwcRK1OPIGoaFbfxDxiZEF0g/Wf
 WZTzfENjf1Kkd9WqwAXcCNoFbzDnlP8bAmshkaiZj197HIj8dSp1nVhTleFW6IFkdx5EST685BT
 6nsR7Mvvl5xxPXg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

This series ensures, that when invalid value is detected or mismatch
between value defined in the device-tree and the read from the
touchscreen is observed, the user is notified and zero is ignored.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
David Heidelberg (2):
      Input: rmi4 - report difference between platform data and detected coord in F12
      Input: rmi4 - fallback to platform data for x/y-mm in F12

 drivers/input/rmi4/rmi_f12.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)
---
base-commit: 95d6a9ccef99117115e41e9adb271243bd5e985b
change-id: 20260731-respect-x-y-mm-f74a2970e9b7

Best regards,
--  
David Heidelberg <david@ixit.cz>



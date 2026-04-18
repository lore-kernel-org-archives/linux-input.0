Received: from sonic315-8.consmr.mail.gq1.yahoo.com (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965D2FFDC4
	for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776493993; cv=none; b=nZA0nEH7efpuOkYM+OiB/j2W1ETiOa7Qvc8pQyddN4r0LWFdRP6ZKakdHW2bTzItw/ZLB3FXD6GP0oFUtGZT+5Xv5J9zmuTSzmyT2/cxNVkFCOv3qlj6NHaz6MKjC0uwYkmKuDZTc04Jw+x/htZ/whZak2SQ+CCc1q047rSOJwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776493993; c=relaxed/simple;
	bh=syYlsVI+Cyv8Iu32MCXECG2skpMfIlco1Q2E9koQb+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=CoAS8CfOLJC86kdqYSrcWoXIq7KtYX7/XRVBP24n2dTtntlZl7CIL63cHimduUbI+8jU6bbLwV7+BiXERruQZ/1XSYBTnOjLSfHcjE+1qVHb1nEFwQmGmK68c6Yklt4Xus0KIq61gdD+o1Ha/yaJyF2KAy1IsmA1KRJG4DtpaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=chQjBR/o; arc=none smtp.client-ip=98.137.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="chQjBR/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776493986; bh=mBG7j24/UA6K7DkNwL26nXFDgEt/I9aECPcm83oyrFg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=chQjBR/o4JBEo8u8GnnTuANzd7V3vYWv6k9dJGYZXoTQ8vRjJczwWgSDTMFEQU7WJlKy8nuDT2OCqnIXyiYRc0jlLQX40oIaxiS+ZjcOO6Piw9B5m0cb31xsucGbQbT5/r5Gx8GBjMTBRBVHETFbilOfi/T+69P7hmPXvMc0lgVn/1MSTMqBpKIjRj7Bkhw0twSFNwxkZQvaihzbmzeGZfvEczQUkqmO/m7YQ2vm0NxDcUiFAViRPernmuHu+YFqK6fMjAYMDhahh0Lxh5Mhhort6rhM9keUQeg4LDW30vUkVc3KF9qGpCMuFJQqXBbjw0TO6+2F9mF/krPN3n5tSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776493986; bh=JHuqisyHXg62QsxiYU1TlmQFxHz/9MpNxD5wTjOLGl9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EZmLpNthx2VUEe8U62zVpwHKHdE1gO7AvuxT6SjgISh+0trgFGZ83VJEHv8ZF3UuVqpgttn77VT04Flf2IVmHEXP28lvQ4LP4mhRD+5mgHOjB9KIbimMNw+t+wUnTrzhWqr4R90V9TLNC42EkFFWcviXbYFgXdC4eufUHJHZe4gkWdBHFcB7teCzIo+Zp5lBLi3AhtGZFiovLvUYQr8QkKLLNOJQmIJXecT7lVWd1vBt6PmLcQSl50tYQ+mCbNDlNEs64iXd43edIMl6kCmqlOc/yBkSOUbpMS2VWkQYo0b1do8PykmNSBktbWVlY1NuESK8kvIXinuPGlJRYC5qLw==
X-YMail-OSG: j2eH2QEVM1n.585Kf._9NQGHgBXsRpS8gJUO3XlLmV_tyGhUiMxnDfY1AEUI4HD
 BKPPdQE8Xjx0nr98NnCkUQCX_UGZk9BoRAnUfXfeXUdAJtGlCvW.GXAg9uJjM.YVCZpQaZaayUJr
 YwPzUqBEUUVfzxFVeBO_zBQIQYgqxk5HqnO0mmCkx6uGn4PZCXiVmkdw60RX9KM9IXMsTnr7os8M
 QOzAfQhex5d3zPrw.LaOm3mw.Ah0PhXafEGxtke4a4yuqbS2TVTITfwKjtNZUhEOxdS9JTzMDNi.
 6q26VXGgCXAMZPperEHWxRw3mNSe_2.8CvyLM4Rb_9os4wmpzS.p1hq12UyUT5xHM8b065d4GFh8
 uEtVqNi318IJeMjcM9RFsPB33W285MQx3F44caQvABmkgrW4EmUGfrxnB1e9Y3t26XEpA4bibWf_
 J7LE9EOavR4V8T0qz5oNFsyumB0webJaXhNhJD9IUwv2_iUs73KzXYqC3aOk24BvRnjiZBXcnei4
 .9gTw7lt99RRt_GwEcD.RBOnu03T38g54YMEeIFKYlegYCIptYmyqEJZyJIRm7.g61Juxv0qfE78
 .j7Sa7BTlVrqh5sEFRSrKhs4lvTd3NCuC2qVzq17HfcuQI4eE7d9dNPUaTLirdqRMvLwo8zazPuV
 832Fbz22npeE9AprnZEheiLlS6f4QTMXKzocMjag_P9_7dkwDP0XmF_yE2EMezLC.Um9nTER6X_A
 rNMcu3PBgVocWKCeUGkqJ_KPS9kCAueQamHchu1nQvRZI3ybWZMMpwzo2ioCxh7YOWY8SRcFpNoj
 U3MNMF1GzPTyoQIUgKtfMF0cOJrj_r.XzDEfGpwmYz4dCRACOFNcUA9NqiBlIRzMMlThH4wTWi2U
 FXo1V_3cngqFjmJxP9JGkDVnObCrMW3K5XcWR.jH0_0rkn_Flq3WhuWYmuQ7t90t_uH7ZCkw35_t
 keoUGXZNSB3tFYneBPUhLTw2mGEMet4iscZdsqDVBICVCW1PqUbAzDl_pD8UCYH01xvaI2l1NjeF
 9Oz1Nc_RHaI5391c5tGiqQ9JQ3AjqRMeYEqQTOVUlwBffAenc29C1Wd4oaZjkUqDN.3YNVJNCtFG
 fQPHyvlrQRr2.yWlTGyy9cTPD2jjU211vrHNgxbSAtzsWX8U5Ul82.gZxtV6iYRWvGGoql7IuwHe
 EsbGw_76Mvze_f5FYPB9TxzC7ckr6rnUPSW0Opr2z5SK1eua3gGfLxHDe0NITi6Tfs5fbTxdxhPg
 .PdxwRU.whBcN8nTaGdZ_M_FPyFyg5QmuNeokfkbxwVnUo09kzW.t5exHWNHTwC7nwgzBZKehmJR
 ZKsQUeC0OsuTHqKUbs47HnceAyqPoUJChg1zehfYPIYVgFkJZ0RbnNlhnpHFqqrO4Y.ictfh.TkH
 AJ22lKPzu7yijgb13.aXRJDyWBlSl064qGejecNb6H74ux3xpMTTVtHMJCQIwxfDz.lFS617qAtG
 EQafEuu9JVxK79GTxwa8bBJHfKIoBQBuLfmsVnU_Flwse.l.VVtfxzvGEwxYK7U5Jny8Jq4TShjO
 3ZXzQUQaQMjoQNqK_8ga6gZnVVobrwle3X.SFPYaL6TR3hZG1lZv4BbPkx9TIdMaZz9BHUEi6b2B
 Pi.uPO8yozosBJVwO8Xb0P0BHokxVxx.PY3tLqC8EQ4fuRa2zRpT2pY7FDESmfs0dKUKrRh9zdJs
 hpsrWi9txXRq9PwE_XBxLStQVRIepepu6KB70QsTKYhSeOd_vXYYxsmGdnEhN14fA3nhSNtom.l4
 xpHA8fTvNldFVB2ekFLfkwkuTS1I3bfxjazWgitB4ZmN35YYE0jgzCBAfWWBtnnnVRREnewIfbkL
 7_4knvNMszofbWHwE2tNkg._4axq2CKLiywYHt8KoWxnSGMyQks5FNtIciTwQgygElYxsCU4Nn1s
 p42l1zOIvci3bf50j3B8t8Ucffq_.ilDWwuoynimyulcIuLX.IH37L_PCOTyJKZXz8RRqSAohVTK
 g8P8NCyH2WN7r0mtyLiWAN96v_QZJc6Av47012ZKFnTogZwk4bryNRuD7gZGUX9uW9KNvKNweoMz
 tVxmNZD_NpnPxH3Blvmy6I0KO55uHIm6PyJ5yU1KjfdN9PT7yIK8J0Hvv3eH304LZwu0wf.3GukW
 wJVTullGENvvgtYhpb20a35NDjxc1YKmx4L4abrfWnuzD.ev_Sx2ApJfQekFPJ21iS6o_HGbigKK
 IrlhfssOQSeF_GnloshKmV3By7Gp_GoCDMGkF4033e9CwwGpa6ujAUROTdQ5r09GPCVtVKLkMTVm
 UkDZ1TrFh
X-Sonic-MF: <sainiharpreet29@yahoo.com>
X-Sonic-ID: d89da938-ab56-4417-a5e6-f0b226bcd0e7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sat, 18 Apr 2026 06:33:06 +0000
Received: by hermes--production-bf1-697f88457-nwz5r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9b8d7fe4763979ee0d1c15afeb8a3b24;
          Sat, 18 Apr 2026 06:22:48 +0000 (UTC)
From: Harpreet Saini <sainiharpreet29@yahoo.com>
To: Rob Herring <robh@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 0/2] Add PixArt PAJ7620 gesture sensor support
Date: Sat, 18 Apr 2026 02:22:31 -0400
Message-ID: <20260418062241.104697-1-sainiharpreet29@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260418062241.104697-1-sainiharpreet29.ref@yahoo.com>

This series adds support for the PixArt PAJ7620 gesture sensor.
The first patch provides the DT bindings, and the second patch
implements the input driver.

Changes in v3:
- Moved sensor power-up and paj7620_init() to input open/close 
  callbacks
- Implemented dynamic keymap support via 'linux,keycodes' DT property
  and enabled userspace adjustment via EVIOCSKEYCODE.
- Updated YAML bindings to include mandatory vdd, vbus, and vled
  supplies.
- Added gpio-controller properties to YAML for hardware completeness.
- Verified with dt_binding_check and checkpatch.pl --strict.

Harpreet Saini (2):
  dt-bindings: input: Add PixArt PAJ7620 gesture sensor
  input: misc: Add PixArt PAJ7620 gesture sensor driver

 .../bindings/input/pixart,paj7620.yaml        |  79 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/input/misc/Kconfig                    |  12 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/paj7620.c                  | 338 ++++++++++++++++++
 5 files changed, 432 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/
 pixart,paj7620.yaml
 create mode 100644 drivers/input/misc/paj7620.c

-- 
2.43.0


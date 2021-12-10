Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEF2C433F5
	for <linux-input@archiver.kernel.org>; Fri, 10 Dec 2021 02:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbhLJCbA (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 9 Dec 2021 21:31:00 -0500
Received: from mail-4317.proton.ch ([185.70.43.17]:31494 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbhLJCbA (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2021 21:31:00 -0500
Date:   Fri, 10 Dec 2021 02:27:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1639103244;
        bh=vRyw/Mk1pPGhOpHZt/19uH6fr0dEklnMVGC8i+6yKLU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=oLGbUBbHSsSrL8Yok1F45y1DFHeQmYRoIZCxVfAjVIqOcmEiAQHbXl4O8auBTqpal
         iXbp8WNChbW55xepER7vqW8ZAapMShZGeWrnXtt4Km7ycWR8IlgOLhJp7299rOFSe3
         wQo4Nbmhh51enb4XSC7bYJ7sLU4pusG3rx66Ozlo=
To:     caleb@connolly.tech, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Joel Selvaraj <jo@jsfamily.in>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH v4 5/6] arm64: dts: qcom: sdm845-xiaomi-beryllium: add haptics
Message-ID: <20211210022639.2779173-6-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Joel Selvaraj <jo@jsfamily.in>

Enable the pmi8998 SPMI haptics driver and configure the play rate for the
hardware.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/ar=
m64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 580d4cc1296f..981711e535d2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -312,6 +312,11 @@ resin {
 =09};
 };

+&pmi8998_haptics {
+=09status =3D "okay";
+=09qcom,wave-play-rate-us =3D <4878>;
+};
+
 /* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
 &q6afedai {
 =09qi2s@22 {
--
2.34.1



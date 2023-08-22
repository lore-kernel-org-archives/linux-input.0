Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2782BEE49AD
	for <linux-input@archiver.kernel.org>; Wed, 23 Aug 2023 02:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjHWCRD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 22 Aug 2023 22:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHWCRC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Aug 2023 22:17:02 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 19:16:58 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E60E4A
        for <linux-input@vger.kernel.org>; Tue, 22 Aug 2023 19:16:58 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-07-64e5539cee9c
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 13.12.10987.C9355E46; Wed, 23 Aug 2023 05:32:28 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=C2lsoOf4pbM75uNMOUTtSYzR83qEPeUPp2/nBjP3XTwRoiHrSgzvgfTlUA9qVgYAF
          fKWHDIGv01sU8gEvniWruifC9kC4vFfZ/mU4t7Q1yhRAN5HegAsG5wbLwMQVn/dFK
          LY4S6Z/vFHR5NBC6gv9NJSuKUpNv80yCfrmYGIaSY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=haS77ge+sDpqvcJNcPLQbFkHC3n+8zSckCFpiupWGf69HBFoyN3LIImVt2uB+GrCT
          Hgr8IRUDX1nPReip1HACkWGyrMgDU8eF1V/qfPpQmTyz6voKPcAMp/Pg0i0QxEqAz
          e+Cqe2LjmdNKBhkq6RyFCFyBvLA1kNZdvV+ngYD2o=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:02 +0500
Message-ID: <13.12.10987.C9355E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-input@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:16 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVyyUKGW3dO8NMUg7+zzS1ufvrG6sDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGknUXWAp2M1e09S9iaWB8zNTFyMkhIWAisfPeHrYuRi4OIYE9
        TBJ3p39hBnFYBFYzS8zf+5UNwnnILDHxymdGiLJmRol7jX1AZRwcvALWEnc3i4GMYhbQk7gx
        dQobiM0rIChxcuYTFoi4tsSyha/BypkF1CS+dpWAhIUFxCQ+TVvGDhIWEZCXuHXEFCTMJqAv
        seJrMyOIzSKgKvHq3DWwiUICUhIbr6xnm8DIPwvJsllIls1CsmwWwrIFjCyrGCWKK3MTgYGW
        bKKXnJ9bnFhSrJeXWqJXkL2JERiEp2s05XYwLr2UeIhRgINRiYf357onKUKsiWVAXYcYJTiY
        lUR4pb8/TBHiTUmsrEotyo8vKs1JLT7EKM3BoiTOayv0LFlIID2xJDU7NbUgtQgmy8TBKdXA
        aDfv2DT7PJ4Nm0oP7ZotPsupwdDHL2mN58ppC2V72i9LO+p35b5b0liygJU/5p3pbLl3eTc0
        9nsK2z07smcJ7z9Z3QVOPefLHBN+fVgsmOC75buO/Ltuaf1o89ev0m+ZXJ/iYvqj1b10VXDg
        3B7/lHlyxpbpjcuXRh5ayPLWesOV01YRtbH2SizFGYmGWsxFxYkAHfgIyz4CAAA=
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China


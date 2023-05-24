Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9434CC77B7C
	for <linux-input@archiver.kernel.org>; Wed, 24 May 2023 15:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjEXPWU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 24 May 2023 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjEXPWM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 May 2023 11:22:12 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D44A9;
        Wed, 24 May 2023 08:22:11 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-76c64da0e46so33416639f.0;
        Wed, 24 May 2023 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684941730; x=1687533730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3n1uJLN0m7n/AtQaqoig453RKnSASeM4a+op9Bk4ANQ=;
        b=kgqt5HEwUYlmmi7qOYd7F+MFfER50c6RAMOMxrhVVUx2/NwAVvnHc8sTphpPDcUj2m
         VxKnZASmatODmSldHfVFQ2IKDyoJXXQeFJMiEm5HI742QrhEo0t+hE5QnOQs5nrRbrFi
         bU3rd5SBlYTFDl88fZ9ceDFsVRzG9UHG8f8zRX6xeyb9taLncqtakxtVboVZVI9DQFWE
         wSJ8gL20qQdYfAWEXL15dlYsp9EkdEdWnx+FhZX+crzYWb1UUPfjHf3+cWPmI9nTPnrD
         vDPu+G5MlFQLQD46NcWzCYLu7i6Ob+VM/9fMW5ydc8PgzRWxwNW+XkiNs2Kprr9L2fZb
         wkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684941730; x=1687533730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3n1uJLN0m7n/AtQaqoig453RKnSASeM4a+op9Bk4ANQ=;
        b=KY/5WKht4EmzMN2IMwYfh9zWl0XCYOBWT4K3YPHq0XznQZIO3vXedMUuXr7QPE1itu
         SiYheKZ3l27KveL4dwjMNNHJOll7pas4GMsOKbc+MnJssCoAk309fO2GvQKl7B/LfBdK
         7lW4uVPj8NE7dOMo100x6z1FHaskVuAA38Yz+D0bhnnBAuceRV/49kaS2VmPvQd/CO+0
         coh+e3NxZ6WcYJQGHDvFPc8XRJH9K1WKxo8URNkXBflOD5MV3Xz4fo4c4CyknfEJ+V/H
         6MVfjxO1XRteIVnQz6wXWmleC34RyGLzeOIku2YLGc+zuiMbpC5vEJ2LxxfVCFPwll/k
         3FrA==
X-Gm-Message-State: AC+VfDxVRK5veEEWDHGCfUwXYteHkbYsZIH1E/bWEiOE23lDOctV+SuC
        Ia14MvryDcpKr63iSe4ht8zwxslmop02bOo5U7woY1HKOCM=
X-Google-Smtp-Source: ACHHUZ4DVvS3NwY3eUr5StYMyD2WyqucHVeVAmQncK5Iwh9MhYV1Z0JiSV625OxTyBD+Kb1AGgPYim0CkyzC8x/jjAU=
X-Received: by 2002:a92:dc06:0:b0:338:1b0f:28eb with SMTP id
 t6-20020a92dc06000000b003381b0f28ebmr11732331iln.23.1684941730354; Wed, 24
 May 2023 08:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAO78Kho+xuhUeUY9cd26j_1g2ctspnBUdb+viBemf3qKOB13Vg@mail.gmail.com>
In-Reply-To: <CAO78Kho+xuhUeUY9cd26j_1g2ctspnBUdb+viBemf3qKOB13Vg@mail.gmail.com>
From:   Nathan Schulte <nmschulte@gmail.com>
Date:   Wed, 24 May 2023 10:21:59 -0500
Message-ID: <CAO78KhoyDaaEvmiZFNNdfOgnoxRbF6JOSnKAB6K9JGwquGme9A@mail.gmail.com>
Subject: Fwd: ASUS TUF FA617 [laptop] PS/2 keyboard woes
To:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hello.  Myself and others are experiencing issues with recent hardware
from ASUS; keyboards in laptops such as model FA617XT, FA617NS, etc.
seem to not work with Linux.  The keyboards appear to work fine enough
with the BIOS and GRUB, but choke under Linux of various recent
versions (5.19, 6.1, 6.3).

An existing Kernel.org Bugzilla bug exists
(https://bugzilla.kernel.org/show_bug.cgi?id=217336) though it's noted
likely the INPUT subsystem does not use this tracker.  Various logs
with i8042 debug are available there, as is some testing notes from
various patches about the interrupt configuration, though it seems
without success.

I'd like to diagnose the issue with the FA617XT if possible;
assistance with things to trial would be appreciated.

Paul Menzel suggests to not support ASUS by returning the device, and
I'm inclined to agree, however it seems ASUS is the only vendor
currently offering the latest AMD Ryzen 7000 chips in conjunction with
AMD Radeon discrete graphics, which I _would_ like to support.  I am
honestly surprised there's any issue at all, given this model is the
"AMD Advantage Edition" and ought to have been thoroughly tested and
vetted in partnership with AMD.  None-the-less, ASUS claims to "not
support the Linux operating system."

Thank you for your time and any assistance with this issue.

--
Nate

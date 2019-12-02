Return-Path: <SRS0=TjKU=ZY=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00648C432C0
	for <linux-input@archiver.kernel.org>; Mon,  2 Dec 2019 18:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AD320715
	for <linux-input@archiver.kernel.org>; Mon,  2 Dec 2019 18:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uP8y/Lzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfLBSK7 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:10:59 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35668 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfLBSK7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 2 Dec 2019 13:10:59 -0500
Received: by mail-pj1-f66.google.com with SMTP id s8so74287pji.2;
        Mon, 02 Dec 2019 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OWl5LMlyWthCEsecxcscMjlc8//jLun1U4+HNkZP2EQ=;
        b=uP8y/LziWCPvQnk7isxZu1yhkNU4fMAOvEeJBpxzG1hUwojItHcdqelLFdCjb+vXJl
         VdYqUYnEuTe7F/sZ0mW45o+WXnEyj0KFG2EttqOFSnTGHFscKDpd/zWdDyLDVq753J1A
         Wtp1poTat69yQymDjAaChATPzk6U8M1t7KVGxOJhBTNo26W1p4eocxQ0kTXHRXjQrrOj
         gi7KUg8UD6eO2zu4BYA2GCtiOzONY2qMV0d1qjhzvNvdmrQWGrA2SVoM6vuQuStLfTts
         H34wikchwvobC63jBu9jJjtnmLhWgBTmS34tnc+ncdGAdP+Se0sHHhVBNZdB4TxZJl9T
         ao+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OWl5LMlyWthCEsecxcscMjlc8//jLun1U4+HNkZP2EQ=;
        b=aYDqIRXz4rXiY9nR01d0mUoVXHHtrOoRhxXkfPOeorwUU6znUpou2dVElpP9jJQsoV
         9JcjSphYajU9Je7S9vJ+N30Uq5+JNRIiJtMakK2evGpQ/DN8/9E3SoZAaDNbwSvBeYkX
         wX8hvolAySMdDJ+3F+hEZy3+Df/xFEQlUSr6fldIzeg9NhBRU1nPfdOQT4DkSXfifZEM
         R9Kg7qpKZ3+IRkPDXGL7ZwExKiS75Oift6pi87NWNlvnk6EXJ8y8YWf0Rqiw2YeN4vi+
         LM5GuBfMDDKrU9dXFMVmC8pN/g889KVjPthXsr2SRPR+vbvsj98ew1aTmH/ry40NAZRi
         ELmA==
X-Gm-Message-State: APjAAAWi9B5EtwzO2iVjZhnjjbie9Gf4E62fzyiW661UidIuc7cnoQaq
        dUTK2s3e4oezWfQb9Zpos5s=
X-Google-Smtp-Source: APXvYqwb+PHDoFPOZYqIaZPMZD2O8EccPICF7fxGPPwMqJjvCNUXFL4eFf6NfxpqCyuQOKO87y/vjg==
X-Received: by 2002:a17:90a:b304:: with SMTP id d4mr409661pjr.142.1575310258156;
        Mon, 02 Dec 2019 10:10:58 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h185sm236616pgc.87.2019.12.02.10.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 10:10:57 -0800 (PST)
Date:   Mon, 2 Dec 2019 10:10:54 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Vasut <marex@denx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ili210x - add ili2120 support
Message-ID: <20191202181054.GF50317@dtor-ws>
References: <20191119180543.120362-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119180543.120362-1-luca@z3ntu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Luca,

On Tue, Nov 19, 2019 at 07:05:43PM +0100, Luca Weiss wrote:
> This adds support for the Ilitek ili2120 touchscreen found in the
> Fairphone 2 smartphone.

The driver has been reworked recently, please update on top of the
latest version.

Thanks.

-- 
Dmitry

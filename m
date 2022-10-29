Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE420C433FE
	for <linux-input@archiver.kernel.org>; Sat, 29 Oct 2022 16:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJ2QEo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2QEm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 29 Oct 2022 12:04:42 -0400
Received: from redpilled.dev (redpilled.dev [195.201.122.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F89FBE0D;
        Sat, 29 Oct 2022 09:04:40 -0700 (PDT)
Date:   Sat, 29 Oct 2022 19:04:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redpilled.dev;
        s=mail; t=1667059478;
        bh=duvuJpvVZjElAzzH5OBH9LJGkPHC6PM7nm/M0Al272o=;
        h=Date:From:To:CC:Subject:In-Reply-To:References;
        b=IkWy6m6+zjKF8GENeCi8StLiC3+KaCZfZFqQXNPl5gfqCV2vV2pyuL2nVAov1wEQE
         1Fu1uP2axe31G9OOfW8sx5068oA1iSUtaXOMdL2istfD3b011CJzPdhFw6wDFtui6u
         3NI7lKCH9bOburC0Jf23Su/oSw2s2J7LjJZPZqcs=
From:   Mia Kanashi <chad@redpilled.dev>
To:     =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
CC:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Grosse <andig.mail@t-online.de>
Subject: Re: [PATCH v2] HID: uclogic: Add support for XP-PEN Deco LW
In-Reply-To: <20221029145511.GA7941@elementary>
References: <20221028082348.22386-1-jose.exposito89@gmail.com> <ED1CBF63-A70C-44FF-9F0B-80090EB347EA@redpilled.dev> <20221029075832.GA8790@elementary> <21CA0A00-1B9F-4E97-B942-A3B7CAA2B52E@redpilled.dev> <C7FD0EC0-899A-4D29-8363-D2FAD8E89BBD@redpilled.dev> <20221029145511.GA7941@elementary>
Message-ID: <92A2ED40-1A24-4805-A64B-41B14851141E@redpilled.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

>The problem is that the battery is fetched when the USB dongle is
>connected=2E However, the tablet might not be paired at that point=2E

Big thanks for the explanation, i've looked at this code before but couldn=
't see exactly what's wrong=2E


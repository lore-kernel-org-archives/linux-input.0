From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sun, 31 Dec 2017 01:37:15 +0800
Message-ID: <02082a9b-8fdd-0878-0daa-ead72743d5fd@canonical.com>
References: <f8795209-1b95-81a5-5fbe-f3e3fdc0d18f@canonical.com>
 <20171230095705.GA1861@marax.lan.yath.de>
 <4ca11d3d-4e7c-5bef-1811-9bc95b6e901a@canonical.com>
 <20171230141138.GA23284@marax.lan.yath.de>
 <d8770041-baf4-205e-7818-7ea477f69a29@canonical.com>
 <20171230144040.GB23284@marax.lan.yath.de> <20171230150235.GA19890@kroah.com>
 <4eeea63f-3131-0571-26e4-0f645dd3bc62@canonical.com>
 <20171230152616.GA26378@kroah.com>
 <0eb65344-d160-bb14-723a-1d06ac3e1b33@canonical.com>
 <20171230155358.GE23284@marax.lan.yath.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44162 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdL3RhZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 12:37:25 -0500
In-Reply-To: <20171230155358.GE23284@marax.lan.yath.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Schmidt <yath@yath.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

I don't have X1C5 now, but give a quick test on: X1 Yoga 3rd with
trackpoint (LEN009a), X1 yoga is pretty similar as X1 Carbon on
trackpoint/touchpad.

When trackpoint(without the commit) is recognized as "PS/2 Generic
Mouse", scroll mode does *NOT* work.

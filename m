From: Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH] input: synaptics: min_max quirk for Thinkpad E440
Date: Wed, 25 Mar 2015 10:04:24 +0100
Message-ID: <CADscph30SsHY-UxzzixGamALzapbwQ9LoR+az8iYm58jpQxwjw@mail.gmail.com>
References: <1427246428-7070-1-git-send-email-filipayazi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33710 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbbCYJEZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Mar 2015 05:04:25 -0400
In-Reply-To: <1427246428-7070-1-git-send-email-filipayazi@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Filip Ayazi <filipayazi@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org

On 25 March 2015 at 02:20, Filip Ayazi <filipayazi@gmail.com> wrote:
> Sets min_max_quirk values for LEN2006 touchpad found in Lenovo Thinkpad E440
> (board_id=2691).

Dmitry already applied a patch for the E440:
    http://www.spinics.net/lists/linux-input/msg37497.html

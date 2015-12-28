From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev: avoid storing newest SYN_REPORT when
 dropping all events
Date: Mon, 28 Dec 2015 15:41:25 -0800
Message-ID: <CAKdAkRR0aiziybrsDnvNwC7qCY7vg3K4UHaWfwkZ9oX7hguQOQ@mail.gmail.com>
References: <1450985148-804-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33613 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbbL1Xl0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Dec 2015 18:41:26 -0500
In-Reply-To: <1450985148-804-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Aniroop Mathur <aniroop.mathur@gmail.com>

Hi Aniroop,

On Thu, Dec 24, 2015 at 11:25 AM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> The newest event can be SYN_REPORT in case of dropping all old events when
> buffer is full, but as now there is no device data available to read so
> lets drop SYN_REPORT as well and store only SYN_DROPPED.
>

We can not drop the SYN_REPORT event in this case as userspace needs
it to determine if the events that are coming after SYN_DROPPED are
part of a full packet or if they belong to a partial packet. From
Documentation/input/event-codes.txt:

* SYN_DROPPED:
  - Used to indicate buffer overrun in the evdev client's event queue.
    Client should ignore all events up to and including next SYN_REPORT
    event and query the device (using EVIOCG* ioctls) to obtain its
    current state.

Thanks.

-- 
Dmitry

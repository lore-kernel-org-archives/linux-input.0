From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [Dell Inspiron 17R SE 7720] Synaptics touchpad recognized as PS/2
 Generic Mouse
Date: Mon, 23 Dec 2013 10:47:20 -0800
Message-ID: <CAJiQ=7CG-C4RR7xO_W+SKai-fLKr6xutAn5L0omuLgDPhBtFHg@mail.gmail.com>
References: <52B87EE0.5030104@r15n.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40290 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab3LWSrU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Dec 2013 13:47:20 -0500
Received: by mail-pd0-f171.google.com with SMTP id z10so5438961pdj.2
        for <linux-input@vger.kernel.org>; Mon, 23 Dec 2013 10:47:20 -0800 (PST)
In-Reply-To: <52B87EE0.5030104@r15n.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert van Geerenstein <info@r15n.nl>
Cc: linux-input@vger.kernel.org, Tommy Will <tommywill2011@gmail.com>, Justin Clift <jclift@redhat.com>

On Mon, Dec 23, 2013 at 10:20 AM, Robert van Geerenstein <info@r15n.nl> wrote:
> My touchpad is detected as a PS/2 Generic Mouse on my Dell Inspiron 7720
> (17R SE).
> It only has the functionality of a generic mouse (movement, left clik, right
> click) and no scrolling or multitouch.

Hmm, doesn't this laptop have an ALPS Dolphin V2 touchpad (not Synaptics)?

Tommy and Justin were working on this a while back.  There are a few
patches in the list archives that you could try out.  I believe
they're mostly ready for merging except for one remaining issue with
the trackstick.

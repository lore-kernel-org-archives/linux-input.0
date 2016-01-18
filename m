From: Lauri Kasanen <cand@gmx.com>
Subject: Re: MOUSE_PS2_VMMOUSE and input/mice
Date: Mon, 18 Jan 2016 10:30:38 +0200
Message-ID: <20160118103038.9cda0501.cand@gmx.com>
References: <20160115123928.d06e1fed.cand@gmx.com>
	<5698D343.3000606@vmware.com>
	<20160115132312.654ad5aa.cand@gmx.com>
	<56991418.1070701@vmware.com>
	<20160115175040.GA5664@dtor-ws>
	<569938E7.3090509@vmware.com>
	<20160116173945.cb1f14b9.cand@gmx.com>
	<20160116181635.GA9203@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:51456 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899AbcARIaq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2016 03:30:46 -0500
In-Reply-To: <20160116181635.GA9203@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org

On Sat, 16 Jan 2016 10:16:35 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> So mousedev indeed did not bind to the absolute portion of the device.
> Please try the patch below.

Hi,

The tester reports the patch works. It has some issues in that pixels
moved in-VM do not match pixels moved in the host screen, but at least
the mouse moves now.

- Lauri

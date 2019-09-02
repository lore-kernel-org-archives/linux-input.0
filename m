From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v5] hid-logitech-hidpp: read battery voltage from newer
 devices
Date: Mon, 02 Sep 2019 11:23:41 +0200
Message-ID: <99cffa73439fd0d59fa738d786545f5a6e35ab4d.camel@hadess.net>
References: <20190831175659.7404-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190831175659.7404-1-pedro@pedrovanzella.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pedro Vanzella <pedro@pedrovanzella.com>, linux-input@vger.kernel.org
Cc: lains@archlinux.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 2019-08-31 at 13:56 -0400, Pedro Vanzella wrote:
> Newer Logitech mice report their battery voltage through feature
> 0x1001
> instead of the battery levels through feature 0x1000.
> 
> When the device is brought up and we try to query the battery, figure
> out if it supports the old or the new feature. If it supports the new
> feature, record the feature index and read the battery voltage and
> its status.

FWIW, it wasn't clear to me that there were 3 bytes, and the last one
would contain the battery status. I was under the impression reading
this that the only thing the mouse would send back would be the
voltage, so this might need a slight rewording.

Did you test this with upower? Did it work as you expected?

Cheers

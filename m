From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: fix error message in hid_open_report()
Date: Tue, 1 Oct 2019 16:19:50 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1910011619280.13160@cbobk.fhfr.pm>
References: <5866b49b330a750b44003ebd9f532541dcb13f18.1566587656.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5866b49b330a750b44003ebd9f532541dcb13f18.1566587656.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 23 Aug 2019, Michał Mirosław wrote:

> On HID report descriptor parsing error the code displays bogus
> pointer instead of error offset (subtracts start=NULL from end).
> Make the message more useful by displaying correct error offset
> and include total buffer size for reference.
> 
> This was carried over from ancient times - "Fixed" commit just
> promoted the message from DEBUG to ERROR.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8c3d52fc393b ("HID: make parser more verbose about parsing errors by default")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> ---
> v2: fixed printf() warning spotted by Jiri Kosina <jikos@kernel.org>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

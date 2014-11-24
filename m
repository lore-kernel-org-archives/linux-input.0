From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Reported key not released
Date: Mon, 24 Nov 2014 21:51:47 +0000
Message-ID: <20141124215147.GB14361@srcf.ucam.org>
References: <201411231413.30076@pali>
 <20141124200433.GA3459@srcf.ucam.org>
 <201411242158.33119@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201411242158.33119@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Alex Hung <alex.hung@canonical.com>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 24, 2014 at 09:58:32PM +0100, Pali Roh=E1r wrote:

> So kernel should filter i8042 atk key press events which=20
> represent HW switch?

Yeah - the firmware is sending an "Update rfkill state" message, not a=20
real keypress. If you're already listening for those events through a=20
filter then you should just drop them once you've done the state update=
=2E

--=20
Matthew Garrett | mjg59@srcf.ucam.org

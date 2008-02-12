From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [UPDATED v6] WM97xx touchscreen drivers
Date: Tue, 12 Feb 2008 10:17:38 +0000
Message-ID: <20080212101738.GB21039@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762318AbYBLKRv@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Pete MacKay <linux01@architechnical.net>, Marc Kleine-Budde <mkl@penugtronix.de>, Ian Molton <spyro@f2s.com>, Vincent Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>, dbaryshkov@gmail.com
List-Id: linux-input@vger.kernel.org

This patch series adds support for the touchscreen controllers provided
by Wolfson Microelectronics WM97xx series chips in both polled and
streaming modes.  The series can also be pulled via git from:

	git://opensource.wolfsonmicro.com/linux-2.6-touch upstream

This version incorporates minor bug fixes.

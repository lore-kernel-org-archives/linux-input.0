From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [UPDATED v3] WM97xx touchscreen drivers
Date: Mon, 21 Jan 2008 15:24:02 +0000
Message-ID: <20080121152402.GA7518@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759394AbYAUPaz@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Marc Kleine-Budde <mkl@penugtronix.de>, Ian Molton <spyro@f2s.com>, Vincent Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>, dbaryshkov@gmail.com
List-Id: linux-input@vger.kernel.org

This patch series adds support for the touchscreen controllers provided
by Wolfson Microelectronics WM97xx series chips in both polled and
streaming modes.

Changes since last submission:

 - Replace custom wm97xx bus type with use of the platform bus.
 - Remove reference counting on device open duplicated from input core.
 - Minor style and correctness cleanups.

From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: USB: driver for CM109 chipset
Date: Wed, 29 Aug 2007 12:21:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708291220230.2460@twin.jikos.cz>
References: <7f45d9390708252128p48c30b38we59ca2b6496997dd@mail.gmail.com>
 <46D1CB97.5030000@db.org>  <7f45d9390708262257h2cddf51cva423b339a78ae554@mail.gmail.com>
  <Pine.LNX.4.64.0708271143310.2460@twin.jikos.cz>
 <7f45d9390708282238w7174d105i351e81cd19037d14@mail.gmail.com>
 <Pine.LNX.4.64.0708291029350.2460@twin.jikos.cz> <46D54385.4010704@db.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46D54385.4010704@db.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Alfred E. Heggestad" <aeh@db.org>
Cc: Shaun Jackman <sjackman@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 29 Aug 2007, Alfred E. Heggestad wrote:

> here is an updated version of the CM109 driver, now supporting both 
> KIP1000 and Genius G-talk USB phones. The keymap can be selecting when 
> loading the module using the "phone" parameter.

I will queue the addition to usbhid quirk list in my tree. The driver 
itself should be submitted to Dmitry.

Thanks,

-- 
Jiri Kosina

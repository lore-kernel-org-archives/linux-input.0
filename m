From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] UCB1400 add module parameters for settling delays
Date: Tue, 10 Apr 2007 01:01:47 -0400
Message-ID: <200704100101.47798.dtor@insightbb.com>
References: <f96d234e0704061504q84b7bc9pdf4178c32a55a549@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <f96d234e0704061504q84b7bc9pdf4178c32a55a549@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Cliff Brake <cliff.brake@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Friday 06 April 2007 18:04, Cliff Brake wrote:
> This patch adds module parameters for several delay values used in the driver.
> These delays need to vary based on the hardware design and how much capacitive
> filtering there is on the touch panel inputs, and the resistance of the panel.
>

Applied to the input tree, thank you. 

-- 
Dmitry

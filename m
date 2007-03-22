From: Roger Dahl <rogerdahl@dahlsys.com>
Subject: Re: USB remote control
Date: Thu, 22 Mar 2007 12:48:12 -0600
Message-ID: <4602CF6C.1040004@dahlsys.com>
References: <4602C577.8090207@dahlsys.com> <4602C705.2050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <4602C705.2050105@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

Anssi Hannula wrote:
> Your custom application can call EVIOCGRAB ioctl on the event device.
> Then the events from the device are only sent to this one application :)
It works! Man, that is awesome :) Exactly what I needed. Thank you!

Roger

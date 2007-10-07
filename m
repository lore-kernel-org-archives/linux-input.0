From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch]joydev open count handling
Date: Sun, 7 Oct 2007 14:58:12 -0400
Message-ID: <200710071458.12475.dmitry.torokhov@gmail.com>
References: <200710051710.21518.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710051710.21518.oliver@neukum.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Friday 05 October 2007, Oliver Neukum wrote:
> Hi,
> 
> if joydev_open() fails, the open count has to be adjusted.
> 

Thank you Oliver. This will need some adjustments to be applied to
my tree, I will take care of that.

-- 
Dmitry
